import ballerina/io;
import ballerina/http;

final http:Client OpenAIAPIClient = check new ("https://api.openai.com/v1");

type Message record {
    string role;
    string content;
};

type ChatCompletionRequest record {
    string model;
    Message[] messages;
    float temperature;
};

type MessageResponse record {
    string role;
    string content;
};

type Choice record {
    MessageResponse message;
    string finish_reason;
    int index;
};

type OpenAPIChatResponse record {
    Choice[] choices;
};

public function chatCompletion() returns error? {
    string resourcePath = string `/chat/completions`;
    http:Response response = new;
    map<string|string[]> headers = {"Authorization": "Bearer " + openAIToken, "Content-Type": "application/json"};

    string content = string `"TID: [-1234] [api] [2022-12-12 17:20:05,760] [4f18ef42-69f8-4456-9c9f-a4a59c18cfc1] ERROR {org.wso2.carbon.user.core.common.AbstractUserStoreManager} - org.wso2.carbon.user.core.UserStoreException: Error occurred while retrieving users for filter" .put the above text in the following JSON format,{"message": ,"exception": ,"exceptionmessage": }If any of the values are not available, please leave the corresponding field empty. The message field should only contain the log message without the exception and exception message.make the values as in the text without assumptions`;

    ChatCompletionRequest textPrompt = {
        model: "gpt-3.5-turbo",
        messages: [
            {
                role: "user",
                content: content
            }
        ],
        temperature: 0.2
    };

    response = check OpenAIAPIClient->post(resourcePath, message = textPrompt, headers = headers);
    json openAIAPIResponse = check response.getJsonPayload();

    OpenAPIChatResponse chatResponse = check openAIAPIResponse.cloneWithType(OpenAPIChatResponse);
    string summary = chatResponse.choices[0].message.content;

    ResultOpenAI fromJsonStringWithType = check summary.fromJsonStringWithType(ResultOpenAI);
    io:println(fromJsonStringWithType);

}
