package fun.redamancyxun.eqmaster.backend.service.impl;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import fun.redamancyxun.eqmaster.backend.service.AIChatService;
import okhttp3.*;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Service
public class AIChatServiceImpl implements AIChatService {

    /**
     * 获取AI的高情商回复
     * @param prompt
     * @return
     */
    @Override
    public String chat(String userPrompt) {

        // 构建prompt
        String system = "你是一个具有高情商的社交达人，现在有人来求助你一些情商难题，请你高情商回复。";
        String prompt = "我是一位遇到情商难题的人，我的情商难题是：{" + userPrompt + "}。你是一个具有高情商的社交达人，请你高情商回复我的情商难题。";
        System.out.println("PROMPT：" + prompt);

        // 调用模型API
        // API Key
        String apiKey = "5176fd66b5ebf072d3a4cb3cc7373e8b.GYxJkFGKPDaaMW3A";
        // API endpoint
        String url = "https://open.bigmodel.cn/api/paas/v4/chat/completions";

        // Request body
        JsonObject requestBody = new JsonObject();
        requestBody.addProperty("model", "glm-4-9b:129142139::sbx1fcwt");

        JsonObject systemMessage = new JsonObject();
        systemMessage.addProperty("role", "system");
        systemMessage.addProperty("content", system);

        JsonObject userMessage = new JsonObject();
        userMessage.addProperty("role", "user");
        userMessage.addProperty("content", prompt);

        requestBody.add("messages", new Gson().toJsonTree(new JsonObject[]{systemMessage, userMessage}));

        // Create OkHttp client
        OkHttpClient client = new OkHttpClient.Builder()
                .connectTimeout(1000, TimeUnit.SECONDS) // 连接超时时间
                .readTimeout(3000, TimeUnit.SECONDS)    // 读取超时时间
                .writeTimeout(1005, TimeUnit.SECONDS)   // 写入超时时间
                .build();;

        // Create HTTP request
        Request request = new Request.Builder()
                .url(url)
                .addHeader("Authorization", "Bearer " + apiKey)
                .post(RequestBody.create(MediaType.parse("application/json"), requestBody.toString()))
                .build();

        // Execute request
        String responseBody = null;
        String responseResult = null;
        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful()) {
                if (response.body() != null) {
                    responseBody = response.body().string();
                    JsonObject jsonObject = new Gson().fromJson(responseBody, JsonObject.class);
                    responseResult = jsonObject.getAsJsonArray("choices").get(0).getAsJsonObject().get("message").getAsJsonObject().get("content").getAsString();
                }
                System.out.println("Response: " + responseBody);
                System.out.println("Result: " + responseResult);
            } else {
                System.out.println("Request failed: " + response.code());
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return responseResult;
    }
}
