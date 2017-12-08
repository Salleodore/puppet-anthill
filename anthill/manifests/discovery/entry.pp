
define anthill::discovery::entry (
  $service_name = $title,
  $first = false,
  $locations
) {

  $location_sorted = sorted_json($locations)

  if ($first) {
    concat::fragment { "${environment}-discovery-service-${service_name}":
      target => "${anthill::runtime_location}/discovery-services.json",
      content => "        \"${service_name}\": ${location_sorted}",
      order => "4_${service_name}"
    }
  } else {
    concat::fragment { "${environment}-discovery-service-${service_name}":
      target => "${anthill::runtime_location}/discovery-services.json",
      content => ",\n        \"${service_name}\": ${location_sorted}",
      order => "5_${service_name}"
    }
  }

}