using Progress.Lang.* from propath.

class be.acme.common.Exceptions.RecordNotFoundException
    inherits be.acme.common.HttpError.HttpError :

    /** Default constructor
     */
     constructor public RecordNotFoundException(input ipTableName as character, input ipKey as character):
        super(substitute("&1 not found for key &2", ipTableName, ipKey), OpenEdge.Net.HTTP.StatusCodeEnum:NotFound).
    end constructor.
 
end class.        
