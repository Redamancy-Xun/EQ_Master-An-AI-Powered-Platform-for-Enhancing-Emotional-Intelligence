package fun.redamancyxun.eqmaster.backend.util;//package fun.redamancyxun.chinese.backend.util;
//
//import fun.redamancyxun.chinese.backend.score.IseDemo;
//import org.w3c.dom.Document;
//import org.w3c.dom.Element;
//
//import javax.xml.parsers.DocumentBuilder;
//import javax.xml.parsers.DocumentBuilderFactory;
//import javax.xml.parsers.ParserConfigurationException;
//import javax.xml.transform.Transformer;
//import javax.xml.transform.TransformerException;
//import javax.xml.transform.TransformerFactory;
//import javax.xml.transform.dom.DOMSource;
//import javax.xml.transform.stream.StreamResult;
//import java.io.File;
//
//public class XmlSaver {
//
//    public static void saveToXml(IseNewResponseData resp, String filePath) {
//        try {
//            // 创建 DocumentBuilderFactory 和 DocumentBuilder
//            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//            DocumentBuilder builder = factory.newDocumentBuilder();
//
//            // 创建一个新的 Document 对象
//            Document document = builder.newDocument();
//
//            // 创建根元素
//            Element rootElement = document.createElement("Response");
//            document.appendChild(rootElement);
//
//            // 添加子元素
//            Element codeElement = document.createElement("Code");
//            codeElement.appendChild(document.createTextNode(String.valueOf(resp.getCode())));
//            rootElement.appendChild(codeElement);
//
//            Element messageElement = document.createElement("Message");
//            messageElement.appendChild(document.createTextNode(resp.getMessage()));
//            rootElement.appendChild(messageElement);
//
//            Element sidElement = document.createElement("Sid");
//            sidElement.appendChild(document.createTextNode(resp.getSid()));
//            rootElement.appendChild(sidElement);
//
//            if (resp.getData() != null) {
//                Element dataElement = document.createElement("Data");
//                rootElement.appendChild(dataElement);
//
//                Element statusElement = document.createElement("Status");
//                statusElement.appendChild(document.createTextNode(String.valueOf(resp.getData().getStatus())));
//                dataElement.appendChild(statusElement);
//
//                if (resp.getData().getData() != null) {
//                    String decodedData = new String(decoder.decode(resp.getData().getData()), "UTF-8");
//                    Element decodedDataElement = document.createElement("DecodedData");
//                    decodedDataElement.appendChild(document.createTextNode(decodedData));
//                    dataElement.appendChild(decodedDataElement);
//                }
//            }
//
//            // 创建 Transformer 对象
//            TransformerFactory transformerFactory = TransformerFactory.newInstance();
//            Transformer transformer = transformerFactory.newTransformer();
//
//            // 设置输出格式
//            transformer.setOutputProperty(javax.xml.transform.OutputKeys.INDENT, "yes");
//
//            // 创建 DOMSource 对象
//            DOMSource source = new DOMSource(document);
//
//            // 创建 StreamResult 对象
//            StreamResult result = new StreamResult(new File(filePath));
//
//            // 将 Document 写入文件
//            transformer.transform(source, result);
//
//            System.out.println("XML 文件已保存到: " + filePath);
//
//        } catch (ParserConfigurationException | TransformerException e) {
//            e.printStackTrace();
//        }
//    }
//}