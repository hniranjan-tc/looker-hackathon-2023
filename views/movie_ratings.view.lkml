# The name of this view in Looker is "Movie Ratings"
view: movie_ratings {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.movie_ratings` ;;

  set: detail {
    fields: [title,year,director,actors,genre,rating,metascore,runtime_minutes, revenue_millions,votes]
  }

  dimension: actors {
    type: string
    sql: ${TABLE}.Actors ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: director {
    type: string
    sql: ${TABLE}.Director ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.Genre ;;
  }

  dimension: metascore {
    type: number
    sql: ${TABLE}.Metascore ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.Rank ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.Rating ;;
  }

  dimension: runtime_minutes {
    type: number
    sql: ${TABLE}.Runtime__Minutes_ ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.Title ;;
  }

  dimension: votes {
    type: number
    sql: ${TABLE}.Votes ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }
  dimension: revenue_millions {
    type: number
    sql: ${TABLE}.Revenue__Millions_ ;;
  }

  # Measures

  measure: total_revenue__millions_ {
    type: sum
    sql: ${revenue_millions} ;;  }

  measure: average_revenue__millions_ {
    type: average
    sql: ${revenue_millions} ;;  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

# # create relation between No_of_Votes and ratings
# normalize_No_of_Votes = (df['No_of_Votes']-df['No_of_Votes'].min()) / (df['No_of_Votes'].max()-df['No_of_Votes'].min())
# df['Modified_Rating'] =  normalize_No_of_Votes + df['IMDB_Rating']

}
