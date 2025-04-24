using Progress.Json.ObjectModel.* from propath.
using Progress.Lang.* from propath.

class be.acme.common.HttpError.HttpError
    inherits AppError:

    /* https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml */
    define public property HttpStatusCode as OpenEdge.Net.HTTP.StatusCodeEnum
        get.
        private set.

    constructor public HttpError(input ipErrorMessage as character, input ipHttpStatusCode as OpenEdge.Net.HTTP.StatusCodeEnum ):
        super(ipErrorMessage, 0).
        HttpStatusCode = ipHttpStatusCode.
    end constructor.
 
    method public JsonObject GetHttpErrorAsJson():
        define variable lJsonObject as JsonObject no-undo.
        lJsonObject = new JsonObject().
        lJsonObject:Add("Error", this-object:GetClass():TypeName).
        lJsonObject:Add("ErrorMessage", this-object:GetMessage(1)).
        lJsonObject:Add("ErrorMessageNumber", this-object:GetMessageNum(1)).
        lJsonObject:Add("StackTrace", this-object:CallStack).
        return lJsonObject.
    end method.
end class.     