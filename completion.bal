import ballerinax/openai.text;
import ballerina/io;

public function completion() returns error? {
    text:Client openAIText = check new ({auth: {token: openAIToken}});

    string fileContent = string `"TID: [-1234] [api] [2022-12-12 17:20:05,760] [4f18ef42-69f8-4456-9c9f-a4a59c18cfc1] ERROR {org.wso2.carbon.user.core.common.AbstractUserStoreManager} - org.wso2.carbon.user.core.UserStoreException: Error occurred while retrieving users for filter" .put the above text in the following JSON format,{"message": ,"exception": ,"exceptionmessage": }If any of the values are not available, please leave the corresponding field empty. The message field should only contain the log message without the exception and exception message.make the values as in the text without assumptions`;
    // io:println(string `Content: ${fileContent}`);

    text:CreateCompletionRequest textPrompt = {
        prompt: string ` ${fileContent}`,
        model: "text-davinci-003",
        temperature: 0.3,
        max_tokens: 2000
    };
    text:CreateCompletionResponse completionRes = check openAIText->/completions.post(textPrompt);
    string? summary = completionRes.choices[0].text;

    if summary is () {
        return error("Failed to summarize the given text.");
    }
    // io:println(string `Summary: ${summary}`);
    ResultOpenAI fromJsonStringWithType = check summary.fromJsonStringWithType(ResultOpenAI);
    io:println(fromJsonStringWithType);

}
