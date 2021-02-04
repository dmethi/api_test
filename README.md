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
* Is_carnivore (boolean) - If this is true, the dinosaur is a carnivore. If this is false, the dinosaur is a herbivore.
* Cage (integer) - Represents the ID of the cage that it belongs in. If the value is 0, that means that the dinosaur is not in a cage at the moment.
#### Cages ####
Cages are defined as having the following attributes:
* Capacity (integer)
* Status (string) - Can either be 'ACTIVE' (on) or 'DOWN' (off)
* Num_dinos (integer) - This is the number of dinosaurs currently in the cage.

### API Endpoints ###
This API will expose the following RESTful endpoints:

| Endpoint | Functionality |
| :------------------ | ------------------: |
| GET /cages | List all cages in the park |
| POST /cages | Create new cage |
| POST /cages/filter | Filter cages by power status |
| PUT /cages/:id | Update cage state |
| GET /cages/:id | Show the details of a specific cage |
| DELETE /cages/:id | Delete a specific cage |
| GET /dinosaurs | List all dinosaurs in the park |
| POST /dinosaurs | Add/Import a new dinosaur to Jurassic Park |
| POST /dinosaurs/filter_by_species | Filter dinosaurs by species |
| POST /dinosaurs/filter_by_cage | Filter dinosaurs by cage |
| PUT /dinosaurs/:id/move_to_cage | Move dinosaur to designated cage |
| GET /dinosaurs/:id | Show the details of a specific dinosaur |
| PUT /dinosaurs/:id | Update a specific dinosaur |
| DELETE /dinosaurs/:id | Remove a specific dinosaur from Jurassic Park |

### General Usage Tips ###
* You cannot update a dinosaur's cage while calling the general dinosaur update function. Moving a dinosaur from cage to cage is a specialized function with restrictions, so you must call PUT /dinosaurs/:id/move_to_cage and input the cage that you wish the dinosaur to move to.
* With filtration, you can only filter cages by their power status and you can filter dinosaurs only by their cage and their species. For example, if you want to find all the dinosaurs in Cage 3, you would call POST /dinosaurs/filter_by_cage and enter the json object { ":cage": 3 }.

### Testing ###
These tests use RSpec, FactoryBot, and Faker to generate fake dinosaurs and cages. While the tests are not very thorough (especially for the filtration and moving dinosaurs functionality), they highlight my attempt at using these tools to generate and run test cases. Since the Faker didn't have dinosaur species names, I ended up using Beer brands to represent species differentiation and ended up using some examples of these in my manual tests, so you may see some dinosaurs with the species of Heineken, for example (I'm more familiar with Beer brands than dinosaur species...lol).

### Additional Changes ###
This section addresses any unimplemented features as well as how I would handle concurrency.
#### Features ####
* User authentication - One feature that I didn't implement is user authentication. If this application were to be actually used/deployed, as per the specifications, some functionality (specifically editing cage statuses and moving dinosaurs) should be restricted to only doctors and scientists. It is very likely that there are more users that will be using the system (businessmen, janitors, support staff, etc.) and these users should not be able to edit dinosaurs/cages, etc.
* Enumerated types for species - Given that species names are long (and easy to misspell), there should be a specific set of species that are allowed to be picked/chosen when creating/adding a dinosaur to the system. If not having enumerated types, the entered species should be checked against a database of species names to ensure it is a valid species. Right now, this functionality is not implemented.
* General code cleanliness - I am very new to RESTful APIs and Ruby on Rails, so I am not sure I followed all the conventions of good programming practice in these areas (especially in my implementation of some of the functions in the controllers).
* Input checking - My code as it is does not heavily vet the user inputs that are provided. It relies on the user being very diligent and following a theoretically provided user guide carefully and diligently (bold of me to assume that, I know this is dangerous in most circumstances).
* Having a database that stores the dinosaurs + whether they are carnivores or not -- as of now, there is no association between the species and their diet. For example, it would be possible for users to add in a T-rex that is both a carnivore and a herbivore which is not ideal. Further functionality should ensure that not only are species/diet pairings consistent throughout all dinosaurs but that they are cross referenced with some textbooks or something.
#### Concurrency ####
The biggest issue with concurrency is when two users on the API access an object (cage or dinosaur) at the same time and edit it concurrently. To prevent this from happening, a functionality should that checks the "Updated At" attribute of the object (since Rails tracks that by default) to ensure that it hasn't changed from the time it was accessed. If it has changed, an error message should be returned to the user indicating that the object was unable to be edited.
