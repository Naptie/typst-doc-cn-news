
#import "/typ/templates/template.typ": *

/// Don't worry if you don't write a description. We can generate description automatically
/// by text exporting the content.
#let news-template(
  date: none,
  title: none,
  tags: (),
  description: none,
  lang: none,
  region: none,
  content,
) = {
  set document(title: title, description: description)
  set text(lang: lang, region: region)

  base-template(
    pre-header: current-title.update(title),
    go-back: news-link("content/index.typ"),
    {
      h1(class: "main-title", title)
      div(
        class: "news-prop",
        {
          "Published At: " + date
          "  "
          "Tags: " + tags.join(", ")
        },
      )
      div(
        class: "news-body",
        content,
      )
    },
  )
}

#let _exp(left, right) = {
  block(
    breakable: false,
    html.elem(
      "div",
      (
        left,
        html.elem("div", right, attrs: (style: "padding: 1em;")),
      )
        .map(x => html.elem("div", x))
        .join(),
      attrs: {
        (style: "display: grid; grid-template-columns: 1fr 1fr; gap: 0.5em; ")
      },
    ),
  )
}
#let exp(code, frame: false) = {
  _exp(
    code,
    {
      let body = eval(code.text, mode: "markup")
      if frame {
        html.frame(body)
      } else {
        body
      }
    },
  )
}
#let exp-err(code, msg) = {
  _exp(code, "ERR:\n" + msg)
}
#let exp-warn(code, msg) = {
  _exp(code, eval(code.text, mode: "markup") + "WARN:\n" + msg)
}
#let exp-change(code, before, after) = {
  _exp(
    code,
    html.elem(
      "div",
      (
        [曾经],
        [现在],
        before,
        after,
      )
        .map(x => html.elem("div", x))
        .join(),
      attrs: {
        (style: "display: grid; grid-template-columns: 1fr 1fr; gap: 0.5em; ")
      },
    ),
  )
}
