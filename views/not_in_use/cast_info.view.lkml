# The name of this view in Looker is "Cast Info"
view: cast_info {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.cast_info` ;;
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
    # This dimension will be called "Movie ID" in Explore.

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

  dimension: note {
    type: string
    sql: ${TABLE}.note ;;
  }

  dimension: nr_order {
    type: number
    sql: ${TABLE}.nr_order ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_nr_order {
    type: sum
    sql: ${nr_order} ;;  }
  measure: average_nr_order {
    type: average
    sql: ${nr_order} ;;  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
  }

  dimension: person_role_id {
    type: number
    sql: ${TABLE}.person_role_id ;;
  }

  dimension: role_id {
    type: number
    sql: ${TABLE}.role_id ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
