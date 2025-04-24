using Progress.Lang.* from propath.

class be.acme.common.Exceptions.HttpMethodNotAllowedException
    inherits AppError:

    /** Default constructor
     */
     constructor public HttpMethodNotAllowedException():
        super("Method not allowed":u, 0).
    end constructor.

end class.        
