# The name of this view in Looker is "126 Imdbcsv"
view: imdb_top_1000 {
  derived_table: {
  sql: select * from 'precise-plane-407222.imdb_dataset.imdb_top_1000';;
}
  set: detail {
    fields: [title,year,director,genre,imdb_rating,meta_score,runtime,gross,no_of_votes]
  }

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

  dimension: year {
    type: string
    sql: ${TABLE}.Released_Year ;;
  }

  dimension: title {
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

  measure: gross {
    type: sum
    sql: ${TABLE}.Gross ;;
  }

  measure: runtime {
    type: sum
    sql: ${TABLE}.Runtime ;;
  }



  measure: count {
    type: count
  }
}
