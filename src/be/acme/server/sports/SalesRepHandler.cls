/*------------------------------------------------------------------------
    File        : be.acme.server.sports.SalesRepHandler.cls
    Purpose     : 
    Author(s)   : Bert Strobbe
    Created     : 09/04/2025  
  ----------------------------------------------------------------------*/

using Progress.Json.ObjectModel.* from propath.
using be.acme.common.HttpError.* from propath.
using be.acme.common.Exceptions.* from propath.

block-level on error undo, throw.

class be.acme.server.sports.SalesRepHandler
    inherits OpenEdge.Web.WebHandler:
 
    
    define temp-table eSalesRep no-undo like SalesRep .

    /*------------------------------------------------------------------------------
        Purpose: Default handler for the HTTP GET method. The request being
                 serviced and an optional status code is returned. A zero or
                 null value means this method will deal with all errors.
        Notes:
        @param poRequest The IWebRequest instance representing the call
        @return StatusCode of the response sent to the client
    ------------------------------------------------------------------------------*/
    method override protected integer HandleGet (
        iRequest as OpenEdge.Web.IWebRequest
        ):
        define variable lResponse as OpenEdge.Net.HTTP.IHttpResponse no-undo .
        define variable hQry as handle no-undo.
        define variable htt as handle no-undo.
        define variable cWhere as character no-undo.
        define variable cSalesRep as character no-undo.

        define variable oJsonArray as JsonArray no-undo.

        assign
          lResponse = new OpenEdge.Web.WebResponse ()
          lResponse:ContentType = "application/json"
          .          

        empty temp-table eSalesRep.

        assign cWhere = substitute("for each SalesRep no-lock where true") .
        // ter info: querystring kan je ophalen dmv iRequest:GetContextValue ("QUERY_STRING")
        if num-entries(iRequest:PathInfo,"/") = 3
        then do:
          assign
            cSalesRep = entry(3,iRequest:PathInfo,"/")
            cWhere = substitute(
              "&1 and SalesRep.SalesRep = &2",
              cWhere,
              quoter(cSalesRep)).
        end.

        create query hQry.
        hQry:set-buffers(buffer SalesRep:handle).
        hQry:query-prepare(cWhere).

        hQry:query-open().
        SalesRepLoop:
        do while true:
          hQry:get-next.
          if hQry:query-off-end then leave SalesRepLoop.

          create eSalesRep.
          buffer-copy SalesRep to eSalesRep.            
        end.

        oJsonArray = new JsonArray().
        temp-table eSalesRep:write-json("JsonArray",oJsonArray).

        if cSalesRep > ""
        then do:
          if oJsonArray:Length = 1
          then lResponse:Entity = oJsonArray:GetJsonObject(1).
          else undo, throw new RecordNotFoundException("SalesRep",cSalesRep).
          
        end.
        else do:
          lResponse:Entity = oJsonArray.
        end.
        lResponse:StatusCode = integer (OpenEdge.Net.HTTP.StatusCodeEnum:OK).

        this-object:WriteResponse(lResponse).
        
        catch httpError as HttpError:
          lResponse:Entity = httpError:GetHttpErrorAsJson().
          lResponse:StatusCode = integer(httpError:HttpStatusCode).
          this-object:WriteResponse(lResponse).
        end catch.
        finally:
          if valid-handle(hQry)
          then do:
              if hQry:is-open then hQry:query-close.
              delete object hQry.
          end.
        end finally.                                       
    end method.

    /**
     * Purpose: Handler for unsupported methods. The request being serviced and
     *          an optional status code is returned. A zero or null value means
     *          this method will deal with all errors.
     * Notes:
     * @param poRequest The IWebRequest instance representing the call
     * @return StatusCode of the response sent to the client
     */
    METHOD OVERRIDE PROTECTED INTEGER HandleNotAllowedMethod (poRequest AS OpenEdge.Web.IWebRequest):
 
      UNDO, THROW NEW HttpMethodNotAllowedException().

    END METHOD. 

    /**
    * Purpose: Handler for unknown methods. The request being serviced and an
    *          optional status code is returned. A zero or null value means
    *          this method will deal with all errors.
    * Notes:
    * @param poRequest The IWebRequest instance representing the call
    * @return StatusCode of the response sent to the client
    */
    METHOD OVERRIDE PROTECTED INTEGER HandleNotImplemented (poRequest AS OpenEdge.Web.IWebRequest):

        UNDO, THROW NEW HttpMethodNotImplementedException().

    END METHOD.    

    
    /**
     * Purpose: Writes the HttpResponse to the stream
     * Notes:   Does handle OpenEdge.Core.String seperatly due to (PSC00348040)
     * @param poResponse The Response instance to write
     */
     METHOD PROTECTED VOID WriteResponse (poResponse AS  OpenEdge.Net.HTTP.IHttpResponse):

      DEFINE VARIABLE oWriter AS  OpenEdge.Web.WebResponseWriter NO-UNDO.

      /* dump to stream */
      oWriter = NEW  OpenEdge.Web.WebResponseWriter (poResponse).
      oWriter:Open ().
      oWriter:Close ().

  END METHOD.    
end class.