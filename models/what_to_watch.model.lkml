# Define the database connection to be used for this model.
connection: "lookerdata"

# include all the views
include: "/views/**/*.view.lkml"

# Explores

explore:imdb_1000 {
  from: imdb_1000
  label: "IMDB Ratings based Recommendations"
  view_label: "Recommendations"
  fields: [ALL_FIELDS*
      ]

  join: cosine_similarity {
    type: left_outer
    view_label: "Recommendations"
    relationship: many_to_one
    sql_on: ${imdb_1000.title}=${cosine_similarity.recommendation_title} ;;
  }
}
