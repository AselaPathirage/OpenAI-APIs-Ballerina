import ballerina/io;

configurable string openAIToken = ?;

public type ResultOpenAI record {|
    string message;
    string exception;
    string exceptionmessage;
|};

public function main() returns error? {
    error? chatCompletionResult = completion();
    io:println(chatCompletionResult);
    error? chatCompletionResult2 = chatCompletion();
    io:println(chatCompletionResult2);
}
