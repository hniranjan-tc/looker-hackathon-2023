view: cosine_similarity {

  # You can specify the table name if it's different from the view name:
  sql_table_name: precise-plane-407222.imdb_dataset.movie_similarity ;;


  dimension: series_title {
    label: "Movie Title (to search by)"
    type: string
    sql: ${TABLE}.movie_id_1 ;;
  }

  dimension: recommendation_title {
    type: string
    label: "Recommended Movie Title"
    sql: ${TABLE}.movie_id_2 ;;
    order_by_field: similarity_index
  }

  dimension: similarity_index {
    type: number
    sql: ${TABLE}.cosine_similarity ;;
  }

 }
