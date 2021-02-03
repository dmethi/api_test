# README

### Overall Design Decisions ###
This is an API for managing a system of cages and dinosaurs at Jurassic Park. To structure the entire API, I chose **not** to model the relationship between a cage and a dinosaur as a 1-to-many relationship. This is because, in my view of the system, dinosaurs are an independent entity from cages and shouldn't be seen as belonging or intrinsically tied to a specific cage. This view not only makes more sense (in my opinion) but also enables easier implementation of the following functionalities:
* Indexing + filtering all dinosaurs (since the index function does not have to be accessed through a cage)
* Moving dinosaurs between cages (easier if there's no fixed foreign key); additionally, dinosaurs don't necessarily have to be in a cage at all times (in transit, released into the wild, in different attractions at the park, etc.)

### Model Overview ###
#### Dinosaurs ####
Dinosaurs are defined as having the following attributes:
* Name (string)
* Species (string)
* Diet (boolean) - If this is true, the dinosaur is a carnivore. If this is false, the dinosaur is a herbivore.
* Cage (integer) - Represents the ID of the cage that it belongs in. If the value is 0, that means that the dinosaur is not in a cage at the moment.
#### Cages ####
Cages are defined as having the following attributes:
* Capacity (integer)
* State (boolean) - If this is true, then the cage is powered on. If this is false, the cage is powered off.
* Num_dinos (integer) - This is the number of dinosaurs currently in the cage.

### API Endpoints ###
This API will expose the following RESTful endpoints:

| Endpoint | Functionality |
| :------------------: | :------------------: |
| GET /cages | List all cages in the park |
| POST /cages | Create new cage |
| POST /cages/filter | Filter cages by parameters |
| PUT /cages/:id | Update cage state |
| GET /cages/:id | Show the details of a specific cage |
| DELETE /cages/:id | Delete a specific cage |
| GET /dinosaurs | List all dinosaurs in the park |
| POST /dinosaurs | Add/Import a new dinosaur to Jurassic Park |
| POST /dinosaurs/filter | Filter dinosaurs by parameters |
| GET /dinosaurs/:id | Show the details of a specific dinosaur |
| PUT /dinosaurs/:id | Update a specific dinosaur |
| DELETE /dinosaurs/:id | Remove a specific dinosaur from Jurassic Park |

### Usage Guide ###

### Testing ###

### Additional Changes ###
This section addresses any unimplemented features as well as how I would handle concurrency.
#### Features ####
* User authentication - One feature that I didn't implement is user authentication. If this application were to be actually used/deployed, as per the specifications, some functionality (specifically editing cage statuses and moving dinosaurs) should be restricted to only doctors and scientists. It is very likely that there are more users that will be using the system (businessmen, janitors, support staff, etc.) and these users should not be able to edit dinosaurs/cages, etc.
* Enumerated types for species - Given that species names are long (and easy to misspell), there should be a specific set of species that are allowed to be picked/chosen when creating/adding a dinosaur to the system. If not having enumerated types, the entered species should be checked against a database of species names to ensure it is a valid species. Right now, this functionality is not implemented.
#### Concurrency ####
The biggest issue with concurrency is when two users on the API access an object (cage or dinosaur) at the same time and edit it concurrently. To prevent this from happening, a functionality should that checks the "Modified At" attribute of the object to ensure that it hasn't changed from the time it was accessed. If it has changed, an error message should be returned to the user indicating that the object was unable to be edited.
