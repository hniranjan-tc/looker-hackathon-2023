# Define the database connection to be used for this model.
connection: "lookerdata"

# include all the views
include: "/views/**/*.view.lkml"

# Explores

explore:imdb_500 {
  from: imdb_500
}

# explore:imdb_top_1000 {
#   from: imdb_top_1000
# }

# explore:movie_ratings {
#   from: movie_ratings
# }
