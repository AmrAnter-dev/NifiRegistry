class Address:
    governorate: Optional[str] = None
    city: Optional[str] = None
    district: Optional[str] = None
    street: Optional[str] = None
    building: Optional[str] = None
    floor_no: Optional[str] = None
    apartment: Optional[str] = None
    landmark: Optional[str] = None

    def to_geocoding_string(self) -> str:
        """
        تحويل العنوان لنص مخصص لمحركات الخرائط (GeoLocators).
        يتجاهل رقم المبنى والشقة والعلامات المميزة لضمان مطابقة جغرافية دقيقة.
        """
        parts = [
            self.street,
            self.district,
            self.city,
            self.governorate,
        ]
        # تصفية القيم الفارغة والمسافات الزائدة
        valid_parts = [str(part).strip() for part in parts if part and str(part).strip()]
        return ", ".join(valid_parts)

    def to_display_string(self) -> str:
        """
        عرض العنوان بتنسيق واضح ومنظم للمستخدم مع إيموجي للتوضيح.
        """
        address_parts = []

        # 1. الشارع والحي
        street_info = []
        if self.street:
            street_info.append(f"شارع {self.street.strip()}")
        if self.district:
            street_info.append(f"حي {self.district.strip()}")
        if street_info:
            address_parts.append(" - ".join(street_info))

        # 2. تفاصيل المبنى (العمارة، الدور، الشقة)
        building_info = []
        if self.building:
            building_info.append(f"مبنى {self.building.strip()}")
        if self.floor_no:
            building_info.append(f"الدور {self.floor_no.strip()}")
        if self.apartment:
            building_info.append(f"شقة {self.apartment.strip()}")
        if building_info:
            address_parts.append(", ".join(building_info))

        # 3. العلامة المميزة
        if self.landmark:
            address_parts.append(f"بجوار: {self.landmark.strip()}")

        # 4. المدينة والمحافظة
        city_gov = []
        if self.city:
            city_gov.append(self.city.strip())
        if self.governorate:
            city_gov.append(self.governorate.strip())
        if city_gov:
            address_parts.append("، ".join(city_gov))

        return " 📍 ".join(address_parts) if address_parts else "العنوان غير مكتمل"
