
view: imdb_top_1000 {
  derived_table: {
    sql: Select * from looker_scratch.imdbtop1000datacsv ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: poster_link {
    type: string
    sql: ${TABLE}.Poster_Link ;;
  }

  dimension: series_title {
    type: string
    sql: ${TABLE}.Series_Title ;;
  }

  dimension: released_year {
    type: string
    sql: ${TABLE}.Released_Year ;;
  }

  dimension: certificate {
    type: string
    sql: ${TABLE}.Certificate ;;
  }

  dimension: runtime {
    type: string
    sql: ${TABLE}.Runtime ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.Genre ;;
  }

  dimension: imdb_rating {
    type: string
    sql: ${TABLE}.IMDB_Rating ;;
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.Overview ;;
  }

  dimension: meta_score {
    type: string
    sql: ${TABLE}.Meta_score ;;
  }

  dimension: director {
    type: string
    sql: ${TABLE}.Director ;;
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

  dimension: no_of_votes {
    type: string
    sql: ${TABLE}.No_of_Votes ;;
  }

  dimension: gross {
    type: string
    sql: ${TABLE}.Gross ;;
  }

  set: detail {
    fields: [
        poster_link,
  series_title,
  released_year,
  certificate,
  runtime,
  genre,
  imdb_rating,
  overview,
  meta_score,
  director,
  star1,
  star2,
  star3,
  star4,
  no_of_votes,
  gross
    ]
  }
}
