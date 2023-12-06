# The name of this view in Looker is "Movie Ratings"
view: movie_ratings {
   derived_table: {
    sql: with CTE as (
            select title,year,director,actors,genre,rating,metascore,Runtime__Minutes_, Revenue__Millions_,votes ,
              min(votes) over() as min_votes,
              max(votes) over() as max_votes
            from `imdb.movie_ratings`
            )
            select title,year,director,actors,genre,rating,metascore,Runtime__Minutes_, Revenue__Millions_,votes,
            min_votes,max_votes,
              (votes - min_votes)/(max_votes-min_votes) as normalise_votes
            from CTE

          ;;
  }
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
    hidden: yes
    sql: ${TABLE}.Votes ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }
  dimension: revenue_millions {
    type: number
    sql: coalesce(${TABLE}.Revenue__Millions_,0) ;;
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
  measure: sum_votes {
    type: sum
    sql: ${TABLE}.Votes ;;
  }

# # create relation between No_of_Votes and ratings
# normalize_No_of_Votes = (df['No_of_Votes']-df['No_of_Votes'].min()) / (df['No_of_Votes'].max()-df['No_of_Votes'].min())
# df['Modified_Rating'] =  normalize_No_of_Votes + df['IMDB_Rating']

  dimension: min_votes {
    type: number
    hidden: yes
    sql: ${TABLE}.min_votes ;;
  }

  dimension: max_votes {
    type: number
    hidden: yes
    sql: ${TABLE}.max_votes ;;
  }

  dimension: normalise_votes {
    type: number
    value_format: ".00"
    hidden: yes
    sql: ${TABLE}.normalise_votes;;
  }

  measure: modified_rating {
    type: sum
    value_format: ".00"
    sql: ${normalise_votes} + ${rating} ;;
  }

}
