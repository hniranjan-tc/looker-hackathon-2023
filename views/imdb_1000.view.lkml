view: imdb_1000 {
    derived_table: {
      sql: with CTE as (
            select
              series_title,released_year,
              certificate, runtime, genre,imdb_rating, overview,
              meta_score,director,no_of_votes,gross,stars,
              min(no_of_votes) over() as min_votes,
              max(no_of_votes) over() as max_votes
            from precise-plane-407222.imdb_dataset.imdb_1000
            )
            select
              series_title,released_year,
              certificate, runtime, genre,imdb_rating, overview,
              meta_score,director,no_of_votes,gross,stars,
              min_votes,max_votes,
              round(((no_of_votes - min_votes)/(max_votes-min_votes)),2) as normalise_votes,
              imdb_rating+round(((no_of_votes - min_votes)/(max_votes-min_votes)),2) as modified_rating
            from CTE
            where series_title is not null
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
      type: number
      sql: ${TABLE}.IMDB_Rating ;;
    }

    dimension: meta_score {
      type: string
      hidden: yes
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
      value_format: "0"
    }

    dimension: title {
      type: string
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.Series_Title ;;
    }


    dimension: stars {
      type: string
      sql: ${TABLE}.stars ;;
    }

    dimension: gross {
      type: number
      sql: ${TABLE}.Gross ;;
    }

    dimension: runtime {
      type: number
      sql: ${TABLE}.Runtime ;;
    }

    measure: gross_in_millions {
      type: sum
      sql: ${TABLE}.Gross ;;
    }

    measure: runtime_in_minutes {
      type: sum
      sql: ${TABLE}.Runtime ;;
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
      value_format: "0.00"
      hidden: yes
      sql: ${TABLE}.normalise_votes;;
    }

    dimension: modified_rating {
      type: number
      value_format: "0.00"
      sql:${TABLE}.modified_rating ;;
    }

    measure: avg_rating {
      type: average
      sql: ${imdb_rating} ;;
      value_format: "#.0"
    }
    measure: count {
      type: count
      drill_fields: [detail*]
    }
}
