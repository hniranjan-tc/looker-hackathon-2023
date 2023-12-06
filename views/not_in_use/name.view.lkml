# The name of this view in Looker is "Name"
view: name {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.name` ;;
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
    # This dimension will be called "Gender" in Explore.

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: ignore1 {
    type: string
    sql: ${TABLE}.ignore1 ;;
  }

  dimension: ignore2 {
    type: string
    sql: ${TABLE}.ignore2 ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
