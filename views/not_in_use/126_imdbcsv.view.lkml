# The name of this view in Looker is "126 Imdbcsv"
view: 126_imdbcsv {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.looker_scratch.126IMDBcsv` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Certificate" in Explore.

  dimension: certificate {
    type: string
    sql: ${TABLE}.Certificate ;;
  }

  dimension: director {
    type: string
    sql: ${TABLE}.Director ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.Genre ;;
  }

  dimension: gross {
    type: string
    sql: ${TABLE}.Gross ;;
  }

  dimension: imdb_rating {
    type: string
    sql: ${TABLE}.IMDB_Rating ;;
  }

  dimension: meta_score {
    type: string
    sql: ${TABLE}.Meta_score ;;
  }

  dimension: no_of_votes {
    type: string
    sql: ${TABLE}.No_of_Votes ;;
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.Overview ;;
  }

  dimension: released_year {
    type: string
    sql: ${TABLE}.Released_Year ;;
  }

  dimension: runtime {
    type: string
    sql: ${TABLE}.Runtime ;;
  }

  dimension: series_title {
    type: string
    sql: ${TABLE}.Series_Title ;;
  }

  dimension: star1 {
    type: string
    sql: ${TABLE}.Star1 ;;
  }

  dimension: star2 {
    type: string
    sql: ${TABLE}.Star2 ;;
  }

  dimension: star3 {
    type: string
    sql: ${TABLE}.Star3 ;;
  }

  dimension: star4 {
    type: string
    sql: ${TABLE}.Star4 ;;
  }
  measure: count {
    type: count
  }
}
