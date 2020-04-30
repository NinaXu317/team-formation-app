#Parent class meant to hold all universal functions for generating errors
class ErrorService

    #Generates a new error message hash of given type and message
    #Creating a method for this to ease the reformatting of error message
    #objects if needed later
    def new_error(type, message)
        {type: type, message: message}
    end

    #Returns a string representation of all given errors
    def to_string(errors)
        errors_string = ""
        errors.each do |error_hash|
            errors_string += "\n" + error_hash[:type] + ": " + error_hash[:message] + "\n"
        end
        return errors_string
    end

end
