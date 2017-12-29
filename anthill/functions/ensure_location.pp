#
# Arguments: - A description
#            - A location for Anthill::Location resource
#
# this function realizes the Anthill::Location resource, if it exists, throws explanatory error otherwise


function anthill::ensure_location (String $description, String $location) {

  realize Anthill::Location[$location]

  if ! defined(Anthill::Location[$location]) {
    fail("Cannot find location of ${description}: ${location}. Please define appropriate exported resource: @@anthill::location { '${location}': ... }")
  }
}