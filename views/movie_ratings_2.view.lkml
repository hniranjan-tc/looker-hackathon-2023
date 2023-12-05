# The name of this view in Looker is "Movie Ratings 2"
view: movie_ratings_2 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.movie_ratings_2` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Avg Rating" in Explore.

  dimension: avg_rating {
    type: number
    sql: ${TABLE}.avg_rating ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_avg_rating {
    type: sum
    sql: ${avg_rating} ;;  }
  measure: average_avg_rating {
    type: average
    sql: ${avg_rating} ;;  }

  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: vote_count {
    type: number
    sql: ${TABLE}.vote_count ;;
  }
  measure: count {
    type: count
  }
}
