String mapUnit(String? unit) {
  const unitMap = {
    'ST_MARY': 'St. Mary Unit',
    'ST_SEBASTIAN': 'St. Sebastian Unit',
    'ST_THOMAS': 'St. Thomas Unit',
    'INFANT_JESUS': 'Infant Jesus Unit',
    'ST_JOSEPH': 'St. Joseph Unit',
    'ST_ANTONY': 'St. Antony Unit',
    'HOLY_FAMILY': 'Holy Family Unit',
    'LITTLE_FLOWER': 'Little Flower Unit',
    'ST_GEORGE': 'St. George Unit',
  };

  return unitMap[unit] ?? 'Unknown Unit';
}
