//package fun.redamancyxun.eqmaster.backend.util;
//
//import fun.redamancyxun.eqmaster.backend.common.CommonConstants;
//import lombok.*;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
//import org.apache.poi.ss.usermodel.Sheet;
//import org.apache.poi.ss.usermodel.Workbook;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Component;
//
//import java.io.FileInputStream;
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Map;
//
//@Setter
//@Getter
////@Component
//public class ExcelReader {
//
//    // 单例模式
//    private static ExcelReader excelReaderBeginner = new ExcelReader(0);
//    private static ExcelReader excelReaderDevelopment = new ExcelReader(1);
//    private static ExcelReader excelReaderUpperIntermediate = new ExcelReader(2);
//    private static ExcelReader excelReaderLowerIntermediate =  new ExcelReader(3);
//
//    // unitId 对应课程内容
//    private Map<String, String> dataMap = new HashMap<>();
//
//    // unit 对应课程数
//    private Map<String, Integer> categoryCountMap = new HashMap<>();
//
//    // 总单元数
//    private Integer unitCount;
//
//    // 单例模式
//    public static ExcelReader getInstance(int num) {
//        if (num == 0) {
//            return excelReaderBeginner;
//        } else if (num == 1) {
//            return excelReaderDevelopment;
//        } else if (num == 2) {
//            return excelReaderUpperIntermediate;
//        } else {
//            return excelReaderLowerIntermediate;
//        }
//    }
//
//    private ExcelReader(int num) {
////        String excelFilePath = CommonConstants.LINUX_RESOURCES_STATIC_PATH + "dailyShare.xlsx";
//        String excelFilePath = CommonConstants.WINDOWS_RESOURCES_STATIC_PATH+ "dailyShare.xlsx";
//
//        try (FileInputStream fis = new FileInputStream(excelFilePath);
//             Workbook workbook = new XSSFWorkbook(fis)) {
//
//            Sheet sheet = workbook.getSheetAt(num); // 获取工作表
//
//            for (Row row : sheet) {
//                if (row.getRowNum() == 0) continue; // 跳过标题行
//
//                Cell firstCell = row.getCell(0);
//                Cell thirdCell = row.getCell(2);
//
//                if (firstCell != null && thirdCell != null) {
//                    String firstValue = firstCell.getStringCellValue();
//                    String thirdValue = thirdCell.getStringCellValue();
//
//                    dataMap.put(firstValue, thirdValue);
//
//                    String category = firstValue.split("-")[0]; // 获取第一列中字符‘-’前的内容
//                    categoryCountMap.put(category, categoryCountMap.getOrDefault(category, 0) + 1);
//                }
//            }
//
//            unitCount = categoryCountMap.size();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        // 输出结果
//        System.out.println("Data Map: " + dataMap);
//        System.out.println("Category Count Map: " + categoryCountMap);
//        System.out.println("Unit Count: " + unitCount);
//    }
//
//    /**
//     * 读取课程信息
//     * @throws IOException
//     */
//    @Scheduled(cron = "0 0 0 * * ?") // 每日零点执行
//    public void updateLesson() throws IOException {
//        String excelFilePath = CommonConstants.LINUX_RESOURCES_STATIC_PATH + "lesson.xlsx";
//
//        try {
//            FileInputStream fis = new FileInputStream(excelFilePath);
//            Workbook workbook = new XSSFWorkbook(fis);
//
//            for (int i = 0; i < 4; i++) {
//                Sheet sheet = workbook.getSheetAt(i); // 获取第一个工作表
//
//                for (Row row : sheet) {
////                if (row.getRowNum() == 0) continue; // 跳过标题行
//
//                    Cell firstCell = row.getCell(0);
//                    Cell thirdCell = row.getCell(2);
//
//                    if (firstCell != null && thirdCell != null) {
//                        String firstValue = firstCell.getStringCellValue();
//                        String thirdValue = thirdCell.getStringCellValue();
//
//                        dataMap.put(firstValue, thirdValue);
//
//                        String category = firstValue.split("-")[0]; // 获取第一列中字符‘-’前的内容
//                        categoryCountMap.put(category, categoryCountMap.getOrDefault(category, 0) + 1);
//                    }
//                }
//            }
//
//            unitCount = categoryCountMap.size();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        // 输出结果
//        System.out.println("Data Map: " + dataMap);
//        System.out.println("Category Count Map: " + categoryCountMap);
//        System.out.println("Unit Count: " + unitCount);
//    }
//
//    public static void main(String[] args) throws IOException {
//        ExcelReader excelReader = ExcelReader.getInstance(3);
//        excelReader.updateLesson();
//        System.out.println(excelReader.getDataMap());
//        System.out.println(excelReader.getCategoryCountMap());
//        System.out.println(excelReader.getUnitCount());
//    }
//
//}
