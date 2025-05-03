package WMS;

public class RequestData {
    private String rid, uid, wasteType, wasteImage, locationType, landmark, area, city, district, state, pincode, latitude, longitude, status;

    public RequestData(String rid, String uid, String wasteType, String wasteImage, String locationType, 
                       String landmark, String area, String city, String district, String state, 
                       String pincode, String latitude, String longitude, String status) {
        this.rid = rid;
        this.uid = uid;
        this.wasteType = wasteType;
        this.wasteImage = wasteImage;
        this.locationType = locationType;
        this.landmark = landmark;
        this.area = area;
        this.city = city;
        this.district = district;
        this.state = state;
        this.pincode = pincode;
        this.latitude = latitude;
        this.longitude = longitude;
        this.status = status;
    }

    public String getRid() { return rid; }
    public String getUid() { return uid; }
    public String getWasteType() { return wasteType; }
    public String getWasteImage() { return wasteImage; }
    public String getLocationType() { return locationType; }
    public String getLandmark() { return landmark; }
    public String getArea() { return area; }
    public String getCity() { return city; }
    public String getDistrict() { return district; }
    public String getState() { return state; }
    public String getPincode() { return pincode; }
    public String getLatitude() { return latitude; }
    public String getLongitude() { return longitude; }
    public String getStatus() { return status; }
}