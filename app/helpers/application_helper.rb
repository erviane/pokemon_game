module ApplicationHelper
  # Page title + breadcrumb; crumbs is a hash of label => path (nil path = current page).
  def page_header(title, crumbs = {}, &actions)
    crumb_items = { t("common.home") => root_path }.merge(crumbs).map do |label, path|
      content_tag(:li, path ? link_to(label, path) : label, class: ["breadcrumb-item", ("active" unless path)])
    end
    content_tag(:div, class: "page-header d-flex flex-wrap align-items-end justify-content-between gap-3 mb-4") do
      content_tag(:div) do
        content_tag(:nav, content_tag(:ol, safe_join(crumb_items), class: "breadcrumb mb-1"), "aria-label": "breadcrumb") +
          content_tag(:h1, title, class: "h3 fw-bold mb-0")
      end + (actions ? content_tag(:div, capture(&actions), class: "d-flex flex-wrap gap-2") : "".html_safe)
    end
  end

  # Select options led by a gray, unselectable placeholder that stays shown until a real choice is made.
  def options_with_placeholder(placeholder, choices, selected = nil)
    options_for_select([[placeholder, ""]] + choices, selected: selected.presence || "", disabled: "")
  end

  # Clickable <th> that sorts by `column` (a key in the model's SORTS); keeps search/filter params, resets the page.
  def sort_header(label, column, fit: false, anchor: nil)
    active = params[:sort] == column
    descending = active && params[:dir] == "desc"
    query = request.query_parameters.except("page").merge("sort" => column, "dir" => active && !descending ? "desc" : "asc")
    icon = active ? (descending ? "bi-caret-down-fill" : "bi-caret-up-fill") : "bi-chevron-expand"
    link = link_to("#{request.path}?#{query.to_query}#{"##{anchor}" if anchor}", class: ["sort-link", ("active" if active)], title: t("sort.by", column: label)) do
      safe_join([label, content_tag(:i, "", class: "bi #{icon}", "aria-hidden": true)], " ")
    end
    content_tag(:th, link, class: ("col-fit" if fit), "aria-sort": active ? (descending ? "descending" : "ascending") : "none")
  end

  # Link to a related record (foreign key), styled as inline text rather than a blue link.
  def ref_link(text, path)
    link_to text, path, class: "ref-link"
  end

  def type_badge(type)
    return if type.blank?
    content_tag(:span, type.to_s.capitalize, class: "type-badge type-#{type.to_s.downcase}")
  end

  def field_error(record, attribute)
    messages = record.errors[attribute]
    content_tag(:div, messages.uniq.join(', '), class: "invalid-feedback d-block") if messages.any?
  end

  def hp_bar(current, max)
    percent = max.to_i.positive? ? (current.to_f / max.to_i * 100).clamp(0, 100).round : 0
    tone = percent > 50 ? "success" : percent > 20 ? "warning" : "danger"
    content_tag(:div, class: "hp-bar") do
      content_tag(:div, class: "d-flex justify-content-between small mb-1") do
        content_tag(:span, t("common.hp"), class: "fw-semibold text-body-secondary") + content_tag(:span, "#{current} / #{max}", class: "fw-semibold")
      end +
        content_tag(:div, content_tag(:div, "", class: "progress-bar bg-#{tone}", style: "width: #{percent}%"),
                    class: "progress", role: "progressbar", "aria-valuenow": percent, "aria-valuemin": 0, "aria-valuemax": 100, "aria-label": t("common.health_point"))
    end
  end

  def stat_row(label, value)
    content_tag(:div, class: "stat-row") do
      content_tag(:span, label, class: "text-body-secondary") + content_tag(:strong, value)
    end
  end
end
