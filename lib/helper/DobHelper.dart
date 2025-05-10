String dobMapper(String dob) {
  // Map for months (numeric to text and text to text)
  const monthMap = {
    '01': 'Jan', '02': 'Feb', '03': 'Mar', '04': 'Apr',
    '05': 'May', '06': 'Jun', '07': 'Jul', '08': 'Aug',
    '09': 'Sep', '10': 'Oct', '11': 'Nov', '12': 'Dec',
    'Jan': 'Jan', 'Feb': 'Feb', 'Mar': 'Mar', 'Apr': 'Apr',
    'May': 'May', 'Jun': 'Jun', 'Jul': 'Jul', 'Aug': 'Aug',
    'Sep': 'Sep', 'Oct': 'Oct', 'Nov': 'Nov', 'Dec': 'Dec',
  };

  // Split the input string by '-'
  final parts = dob.split('-');

  // Validate the input format (must have 2 or 3 parts: day-month[-year])
  if (parts.length < 2 || parts.length > 3) {
    return 'Invalid Date';
  }

  // Extract day, month, and optional year
  final day = parts[0];
  final rawMonth = parts[1];


  // Validate and map the month
  final month = monthMap[rawMonth];
  if (month == null) {
    return 'Invalid Date';
  }

  // Return the formatted date
  return '$day $month';
}
