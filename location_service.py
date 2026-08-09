
from typing import  Protocol
import os
import asyncio
import httpx
from geopy.geocoders import Nominatim
from pprint import pprint

# ============================================================
# Common Interface
# ============================================================

class GeoLocatorProtocol(Protocol):

    async def locate(
        self,
        address: str
    ) -> dict[str, float] | None:
        ...


# ============================================================
# Nominatim GeoLocator
# ============================================================

class NominatimGeoLocator:

    def __init__(self, client: Nominatim):
        self._client = client

    async def locate(
        self,
        address: str
    ) -> dict[str, float] | None:

        location = await asyncio.to_thread(
            self._client.geocode,
            address
        )

        if location is None:
            return None

        return {
            "longitude": location.longitude,
            "latitude": location.latitude
        }

# ============================================================
# Google GeoLocator
# ============================================================

class GoogleGeoLocator:

    def __init__(self, client: httpx.AsyncClient):
        self._client = client

    async def locate(
        self,
        address: str
    ) -> dict[str, float] | None:

        api_key = os.getenv("GOOGLE_MAPS_API_KEY","AIzaSyA5J4qMXiEHo72hKQdN1aa44YHxDwTiJZ0")

        if not api_key:
            raise RuntimeError(
                "GOOGLE_MAPS_API_KEY environment variable is not set"
            )

        url = "https://maps.googleapis.com/maps/api/geocode/json"

        params = {
            "address": address,
            "key": api_key,
            "language": "ar",
            "region": "eg"
        }

        response = await self._client.get(
            url,
            params=params,
            timeout=10.0
        )
        
        response.raise_for_status()

        data = response.json()

        if data.get("status") != "OK":
            print("Google status:", data.get("status"))
            print("Google error:", data.get("error_message"))
            return None

        results = data.get("results", [])

        if not results:
            print("result is none")
            return None

        location = results[0]["geometry"]["location"]

        return {
            "longitude": location["lng"],
            "latitude": location["lat"]
        }
# ============================================================
# GeoapifyLocator Service
# ============================================================

class GeoapifyGeoLocator:

    def __init__(self, client: httpx.AsyncClient):
        self._client = client

    async def locate(
        self,
        address: str,
    ) -> dict[str, float] | None:

        api_key = os.getenv("GEOAPIFY_API_KEY","08ac98b1e9cc4b50937cdd599d81d14a")

        if not api_key:
            raise RuntimeError(
                "GEOAPIFY_API_KEY environment variable is not set"
            )

        url = "https://api.geoapify.com/v1/geocode/search"

        params = {
            "text": address,
            "apiKey": api_key,
            "format": "json",
            "lang": "ar",
            "limit": 1,
            "filter": "countrycode:eg",
        }

        response = await self._client.get(
            url,
            params=params,
            timeout=10.0,
        )
        print("HTTP STATUS:", response.status_code)
        response.raise_for_status()

        data = response.json()
        pprint("RESPONSE:")

        results = data.get("results", [])

        if not results:
            pprint("No geocoding results")
            return None

        result = results[0]
        pprint(result)

        return {
            "longitude": result["lon"],
            "latitude": result["lat"],
        }
    
# ============================================================
# GeoLocator Service
# ============================================================

class GeoLocator:

    def __init__(
        self,
        location_client: GeoLocatorProtocol
    ):
        self._client = location_client

    async def get_coordinates(
        self,
        address: str
    ) -> dict[str, float] | None:

        if not address or not address.strip():
            return None
        

        return await self._client.locate(address.strip())

