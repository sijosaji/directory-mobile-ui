/// A function to map blood group enums to user-friendly display values.
String mapBloodGroup(String? bloodGroup) {
  const bloodGroupMap = {
    'A_POSITIVE': 'A+',
    'A_NEGATIVE': 'A-',
    'B_POSITIVE': 'B+',
    'B_NEGATIVE': 'B-',
    'AB_POSITIVE': 'AB+',
    'AB_NEGATIVE': 'AB-',
    'O_POSITIVE': 'O+',
    'O_NEGATIVE': 'O-',
  };

  return bloodGroupMap[bloodGroup] ?? 'Unknown Blood Group';
}
