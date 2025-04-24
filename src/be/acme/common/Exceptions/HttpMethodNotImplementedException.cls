using Progress.Lang.* from propath.

class be.acme.common.Exceptions.HttpMethodNotImplementedException
    inherits AppError:

    /** Default constructor
     */
     constructor public HttpMethodNotImplementedException():
        super("Method not implemented":u, 0).
    end constructor.

end class.        
