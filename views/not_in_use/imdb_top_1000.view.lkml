# The name of this view in Looker is "126 Imdbcsv"
view: imdb_top_1000 {
  derived_table: {
  sql: with CTE as (
            select title,year,director,actors,genre,rating,metascore,Runtime__Minutes_, Revenue__Millions_,no_of_votes ,
              min(no_of_votes) over() as min_votes,
              max(no_of_votes) over() as max_votes
            from precise-plane-407222.imdb_dataset.imdb_top_1000
            )
            select
              title,year,director,actors,genre,rating,metascore,Runtime__Minutes_, Revenue__Millions_,no_of_votes,
              min_votes,max_votes,
              (no_of_votes - min_votes)/(max_votes-min_votes) as normalise_votes,
              imdb_rating+(no_of_votes - min_votes)/(max_votes-min_votes) as modified_rating
            from CTE
;;
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
    type: number
    sql: ${TABLE}.No_of_Votes ;;
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.Overview ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Released_Year ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.Series_Title ;;
  }

  dimension: star1 {
    type: string
    group_label: "Stars"
    sql: ${TABLE}.Star1 ;;
  }

  dimension: star2 {
    type: string
    group_label: "Stars"
    sql: ${TABLE}.Star2 ;;
  }

  dimension: star3 {
    type: string
    group_label: "Stars"
    sql: ${TABLE}.Star3 ;;
  }

  dimension: star4 {
    type: string
    group_label: "Stars"
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
# # create relation between No_of_Votes and ratings
# normalize_No_of_Votes = (df['No_of_Votes']-df['No_of_Votes'].min()) / (df['No_of_Votes'].max()-df['No_of_Votes'].min())
# df['Modified_Rating'] =  normalize_No_of_Votes + df['IMDB_Rating']

  dimension: min_votes {
    type: number
    #hidden: yes
    sql: ${TABLE}.min_votes ;;
  }

  dimension: max_votes {
    type: number
    #hidden: yes
    sql: ${TABLE}.max_votes ;;
  }

    dimension: normalise_votes {
      type: number
      value_format: "0.00"
      hidden: yes
      sql: ${TABLE}.normalise_votes;;
    }

    dimension: modified_rating {
      type: number
      value_format: "0.00"
      sql:${TABLE}.modified_rating ;;
    }
}
