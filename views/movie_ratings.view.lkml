# The name of this view in Looker is "Movie Ratings"
view: movie_ratings {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.movie_ratings` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Actors" in Explore.

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

  dimension: revenue__millions_ {
    type: number
    sql: ${TABLE}.Revenue__Millions_ ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_revenue__millions_ {
    type: sum
    sql: ${revenue__millions_} ;;  }
  measure: average_revenue__millions_ {
    type: average
    sql: ${revenue__millions_} ;;  }

  dimension: runtime__minutes_ {
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
  measure: count {
    type: count
  }
}
