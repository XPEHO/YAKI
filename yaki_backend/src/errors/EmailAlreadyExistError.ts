class EmailAlreadyExistsError extends Error {  
    status : Number;
    constructor (message: string) {
      super(message)
  
      // assign the error class name in your custom error (as a shortcut)
      this.name = this.constructor.name
      this.status = 417
  
      // capturing the stack trace keeps the reference to your error class
      Error.captureStackTrace(this, this.constructor);
    }
    statusCode() {
        return this.status
      }
  }
  
  export default EmailAlreadyExistsError; 