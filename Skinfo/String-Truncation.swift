//Found this extension here: https://gist.github.com/budidino/8585eecd55fd4284afaaef762450f98e
//All credit goes to user budidino.


extension String {
  /*
   Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
   - Parameter length: Desired maximum lengths of a string
   - Parameter trailing: A 'String' that will be appended after the truncation.
    
   - Returns: 'String' object.
  */
  func trunc(length: Int, trailing: String = "") -> String {
    return (self.count > length) ? self.prefix(length) + trailing : self
  }
}

