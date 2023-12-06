# The name of this view in Looker is "Title"
view: title {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.title` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Episode Nr" in Explore.

  dimension: episode_nr {
    type: number
    sql: ${TABLE}.episode_nr ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_episode_nr {
    type: sum
    sql: ${episode_nr} ;;  }
  measure: average_episode_nr {
    type: average
    sql: ${episode_nr} ;;  }

  dimension: episode_of_id {
    type: number
    sql: ${TABLE}.episode_of_id ;;
  }

  dimension: i1 {
    type: string
    sql: ${TABLE}.i1 ;;
  }

  dimension: i2 {
    type: string
    sql: ${TABLE}.i2 ;;
  }

  dimension: i3 {
    type: string
    sql: ${TABLE}.i3 ;;
  }

  dimension: kind_id {
    type: number
    sql: ${TABLE}.kind_id ;;
  }

  dimension: production_year {
    type: number
    sql: ${TABLE}.production_year ;;
  }

  dimension: season_nr {
    type: number
    sql: ${TABLE}.season_nr ;;
  }

  dimension: series_year {
    type: string
    sql: ${TABLE}.series_year ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
