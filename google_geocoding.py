from __future__ import annotations

from dataclasses import dataclass

import httpx


@dataclass(frozen=True)
class Coordinate:
    lat: float
    lng: float


class GeocodingError(Exception):
    """Raised when the Google Geocoding API returns an error or no result."""


class GoogleGeocodingProvider:
    BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"

    def __init__(
        self,
        api_key: str,
        client: httpx.AsyncClient | None = None,
        timeout: float = 10.0,
    ) -> None:
        self._api_key = api_key
        self._client = client
        self._timeout = timeout

    async def _request(self, params: dict) -> dict:
        params = {**params, "key": self._api_key}

        if self._client is not None:
            response = await self._client.get(self.BASE_URL, params=params)
        else:
            async with httpx.AsyncClient(timeout=self._timeout) as client:
                response = await client.get(self.BASE_URL, params=params)

        response.raise_for_status()
        data = response.json()

        status = data.get("status")
        if status != "OK":
            message = data.get("error_message", "")
            raise GeocodingError(f"Geocoding failed: {status} {message}".strip())
        return data

    async def get_coordinates(self, address: str) -> Coordinate:
        """Convert a human-readable address into coordinates."""
        if not address or not address.strip():
            raise ValueError("address must not be empty")

        data = await self._request({"address": address})
        location = data["results"][0]["geometry"]["location"]
        return Coordinate(lat=location["lat"], lng=location["lng"])

    async def get_address_from_coords(self, coordinate: Coordinate) -> str:
        """Convert coordinates into a formatted address (reverse geocoding)."""
        data = await self._request({"latlng": f"{coordinate.lat},{coordinate.lng}"})
        return data["results"][0]["formatted_address"]


# Example usage
if __name__ == "__main__":
    import asyncio

    async def main() -> None:
        provider = GoogleGeocodingProvider(api_key="YOUR_API_KEY")
        coord = await provider.get_coordinates("1600 Amphitheatre Parkway, Mountain View, CA")
        print(coord)
        print(await provider.get_address_from_coords(coord))

    asyncio.run(main())
