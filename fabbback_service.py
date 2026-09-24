#DTOs
from enum import StrEnum
from pydantic import BaseModel, Field 


class ProductFallbackRequest(BaseModel): 
  product_query: str = Field(min_length=1) 
class ProductFallbackStatus(StrEnum):
    SUCCESS = "success"
    NO_ALTERNATIVE = "no_alternative"
    INSUFFICIENT_INFORMATION = "insufficient_information"
    WEB_SEARCH_FAILED = "web_search_failed"
class ProductFallbackResult(BaseModel):
    product_query: str
    alternatives: list[ProductRecommendation]
    status: ProductFallbackStatus
class WebProductInfo(BaseModel):
  active_ingredients: list[str] 
  strength: str | None 
  route: str | None
class RecommendationRequest(BaseModel): 
  active_ingredients: list[str] 
  strength: str | None 
  route: str
class ProductFallbackError(Exception): """Base exception for product fallback failures.""" 
class NoWebResults(ProductFallbackError): 
    pass

class WebSearchFailure(ProductFallbackError):
      pass
class ProductExtractionFailure(ProductFallbackError):
      pass
class RecommendationFailure(ProductFallbackError):
      pass
#=================================================================================================================================

#==================================================================================================================================
#product fall back tool 

from typing import Dict, Any 
from tools.base import BaseTool 
from models.models import ToolResponse 

class ProductFallbackTool(BaseTool): 
  def __init__( self,
             product_fallback_service: ProductFallbackService,
            ):
        self._product_fallback_service = product_fallback_service 
  @property
  def name(self) -> str:
    return "product_fallback" 
  @property 
  def description(self) -> str: 
    return ( """ Find a local equivalent or alternative for a requested product that was not found by the local product search.
              Use this tool ONLY when ProductSearchTool returned no products.
              The tool will:
              1. Search external web sources.
              2. Extract the requested product's active ingredients, overall strength representation, and route.
              3. Build a recommendation request.
              4. Search the local product database for equivalent or alternative products.
              Do not use this tool for general customer questions.
              """) 
  @property
  def parameters(self) -> Dict[str, Any]: 
    return { "type": "object",
            "properties":
            { "product_query": { "type": "string",
                                "description":
                                ( "The name of the product that was not " "found in the local product database." ),
                               }
            }, 
            "required": ["product_query"], } 
  async def execute( self, arguments: Dict[str, Any], ) -> ToolResponse:
    try: 
      request = ProductFallbackRequest( product_query=arguments["product_query"] )
      result = await self._product_fallback_service.find_alternatives( request ) 
      return ToolResponse( success=True, data=result.model_dump(), ) 
    except NoWebResults as exc:
    return ToolResponse(
        success=True,
        data={
            "status": "no_web_results",
            "message": str(exc),
        },
    )
    except ProductExtractionFailure as exc: 
      return ToolResponse(
        success=True,
        data={
          "status": "insufficient_information",
          "message": str(exc),
        }, 
      ) 
    except WebSearchFailure: # هنا لا نريد أن نعرض exception details للـ LLM/customer 
      return ToolResponse(
        success=False, 
        error="Web search service is temporarily unavailable.",
      ) 
    except RecommendationFailure: 
      return ToolResponse( 
        success=False,
        error="Recommendation service is temporarily unavailable.",
      ) 
    except Exception: 
      return ToolResponse(
        success=False,
        error="Product fallback service failed unexpectedly.",
      )

#=====================================================================================================================
#Web Product Extractor

from abc import ABC, abstractmethod 
from app.llm.async_olama import OllamaClient
from app.models.models import WebSearchResponse, WebProductInfo, 
class ProductInfoExtractor(ABC):
    @abstractmethod
    async def extract( self,
                    search_result: WebSearchResponse,  ) 
      -> WebProductInfo: 
        ...
PRODUCT_EXTRACTION_PROMPT = """ You are extracting pharmaceutical product information from web search results. Extract only information supported by the provided search results. Return:

active_ingredients
strength
route Rules:
Do not invent active ingredients.
Do not invent strength.
Strength represents the overall strength representation written on the product/package.
Do not normalize or calculate strength.
Preserve the strength representation as stated in the source.
Do not convert units.
Do not infer missing strength.
Do not create a separate strength value for each ingredient.
Do not infer the route unless it is supported by the sources.
If route cannot be established, return null.
If active ingredients cannot be established reliably, return an empty list.
Ignore unrelated products in the search results.
"""

class LLMProductInfoExtractor(ProductInfoExtractor): 
    def __init__(self, 
             llm_client = OllamaClient
            
            ):
            self._llm = llm_client
    async def extract( self,
                      search_result: WebSearchResponse, ) -> WebProductInfo: 
        return await self._llm.generate_structured( system_prompt=PRODUCT_EXTRACTION_PROMPT,
                                                   input=search_result, response_model=WebProductInfo, )
#==============================================================================================================================
# ProductFallbackService
from app.models.models import ProductFallbackRequest, ProductFallbackResult, WebSearchResponse,  WebProductInfo
from app.exceptions.exceptions import WebSearchFailure, NoWebResults, ProductExtractionFailure,
class ProductFallbackService:
  def __init__( self, 
           search_service: SearchService,
           product_info_extractor: ProductInfoExtractor,
           recommendation_engine: RecommendationEngine,
          ):
        self._search_service = search_service
        self._product_info_extractor = product_info_extractor 
        self._recommendation_engine = recommendation_engine 
  async def find_alternatives( self,
                              request: ProductFallbackRequest,
                             ) -> ProductFallbackResult:
       search_result = await self._search_web( request.product_query )
       product_info = await self._extract_product_info( search_result )
       recommendation_request = self._build_recommendation_request( product_info )
       alternatives = await self._recommend( recommendation_request )
       if not alternatives:
         return ProductFallbackResult( 
           product_query=request.product_query,
           alternatives=[],
           status="no_alternative",
         )
       return ProductFallbackResult( 
         product_query=request.product_query,
         alternatives=alternatives,
         status="success",
         )
#----------------------------------------------------------------------------------------------------
# helper methods
#----------------------------------------------------------------------------------------------------



async def _search_web(
    self,
    product_query: str,
) -> WebSearchResponse:
    try:
        result = await self._search_service.search(
            WebSearchQuery(
                query=product_query,
                max_results=5,
            )
        )
    except Exception as exc:
        raise WebSearchFailure(
            "Web search service failed"
        ) from exc
    if not result.results:
      raise NoWebResults( f"No web results for: {product_query}" )
    return result


async def _extract_product_info(
  self,
  search_result: WebSearchResponse,
    ) -> WebProductInfo: 
  try: 
    product_info = await self._product_info_extractor.extract( search_result ) 
  except Exception as exc:
    raise ProductExtractionFailure( "Failed to extract product information from web results" ) from exc
  return product_info


def _build_recommendation_request(
    self,
    product_info: WebProductInfo,
) -> RecommendationRequest:
    if not product_info.active_ingredients:
        raise ProductExtractionFailure(
            "Active ingredients could not be established"
        )
    if not product_info.route:
        raise ProductExtractionFailure(
            "Product route could not be established"
        )
    return RecommendationRequest(
        active_ingredients=product_info.active_ingredients,
        strength=product_info.strength,
        route=product_info.route,
    )


async def _recommend( 
  self, 
  request: RecommendationRequest, 
): 
try:
  return await self._recommendation_engine.recommend( request )
except Exception as exc:
  raise RecommendationFailure( "Recommendation engine failed" ) from exc


