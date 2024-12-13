package fun.redamancyxun.eqmaster.backend.util;


public class DisTranUtil {

    private static final  double EARTH_RADIUS = 6378137;//赤道半径(单位m)
    private static final  int SPEED = 80000;//假设的货车运送速度(80000km/h)
    /**
     * 转化为弧度(rad)
     * */
    private static double rad(double d)
    {
        return d * Math.PI / 180.0;
    }

    /**
     * 基于余弦定理求两经纬度距离
     * @param lgn1 第一点的精度
     * @param lat1 第一点的纬度
     * @param lgn2 第二点的精度
     * @param lat2 第二点的纬度
     * @return 运送时间，单位：小时
     * */
    public static Integer tranTime(double lgn1, double lat1, double lgn2, double lat2) {
        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);

        double radlgn1 = rad(lgn1);
        double radlgn2 = rad(lgn2);

        if (radLat1 < 0)
            radLat1 = Math.PI / 2 + Math.abs(radLat1);// south
        if (radLat1 > 0)
            radLat1 = Math.PI / 2 - Math.abs(radLat1);// north
        if (radlgn1 < 0)
            radlgn1 = Math.PI * 2 - Math.abs(radlgn1);// west
        if (radLat2 < 0)
            radLat2 = Math.PI / 2 + Math.abs(radLat2);// south
        if (radLat2 > 0)
            radLat2 = Math.PI / 2 - Math.abs(radLat2);// north
        if (radlgn2 < 0)
            radlgn2 = Math.PI * 2 - Math.abs(radlgn2);// west
        double x1 = EARTH_RADIUS * Math.cos(radlgn1) * Math.sin(radLat1);
        double y1 = EARTH_RADIUS * Math.sin(radlgn1) * Math.sin(radLat1);
        double z1 = EARTH_RADIUS * Math.cos(radLat1);

        double x2 = EARTH_RADIUS * Math.cos(radlgn2) * Math.sin(radLat2);
        double y2 = EARTH_RADIUS * Math.sin(radlgn2) * Math.sin(radLat2);
        double z2 = EARTH_RADIUS * Math.cos(radLat2);

        double d = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)+ (z1 - z2) * (z1 - z2));
        //余弦定理求夹角
        double theta = Math.acos((EARTH_RADIUS * EARTH_RADIUS + EARTH_RADIUS * EARTH_RADIUS - d * d) / (2 * EARTH_RADIUS * EARTH_RADIUS));
        double dist = theta * EARTH_RADIUS;
        return new Integer((int)(dist/SPEED));
    }
}
