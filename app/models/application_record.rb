class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Orders by a whitelisted column key from the URL. columns maps key => SQL expression,
  # or key => [join SQL, expression] when the column lives on a related table.
  def self.sorted(column, direction, columns, default:)
    join, expression = Array(columns[column.to_s]).then { |parts| parts.size == 2 ? parts : [nil, parts.first] }
    return order(Arel.sql(default)) unless expression

    # Empty values count as the smallest, so flipping the direction visibly moves them too.
    direction_sql = direction == "desc" ? "DESC NULLS LAST" : "ASC NULLS FIRST"
    scope = join ? joins(join) : all
    scope.order(Arel.sql("#{expression} #{direction_sql}"), primary_key => :asc)
  end

  # ILIKE pattern for a "contains" search, with the user's % and _ escaped.
  def self.contains_pattern(query)
    "%#{sanitize_sql_like(query.to_s.strip)}%"
  end
end
