type backdrop = [#show | #none | #static]
type buttonType = [#primary | #gray | #negative]

// Extremely simple modal. Buttons would be rendered in your component.
@react.component
let make = (
  ~show=false,
  ~onHide=?,
  ~backdrop=#show,
  ~title=?,
  ~description=?,
  ~buttons=?,
  ~container=?,
  ~cancelLabel=?,
  ~submitLabel=?,
  ~onSubmit=?,
  ~cancelType=#gray,
  ~submitType=#primary,
) => {
  let hide = evt => {
    evt->ReactEvent.Mouse.stopPropagation
    switch backdrop {
    | #none
    | #static => ()
    | #show => onHide->Option.forEach(fn => evt->fn)
    }
  }

  let submit = evt => {
    onSubmit->Option.forEach(fn => evt->fn)
  }

  switch show {
  | false => React.null
  | true =>
    <div
      className="fixed top-0 left-0 right-0 bottom-0 bg-dim inset-0 overscroll-none overflow-y-hidden no-scrollbar">
      {switch backdrop {
      | #static
      | #show =>
        <div
          // mx-[1px] will prevent scrolling parent, do not remove.
          className="absolute w-full h-full mx-[1px] touch-none overscroll-none"
          onClick=hide
        />
      | _ => React.null
      }}
      <div
        className="absolute z-50 bottom-1/2 left-1/2 w-[calc(100vw_-_32px)] max-w-[390px] p-5 bg-white rounded-xl -translate-x-1/2 translate-y-1/2 animate-slide-up"
        ariaModal=true>
        {switch container {
        // container is something takes a whole place of the modal contents
        | Some(container) => <div className="-m-5 rounded-t-xl"> {container} </div>
        | None =>
          <>
            // title
            {title->Option.mapWithDefault(React.null, title =>
              <div className="mt-1 text-xl font-bold line-clamp-2"> {title->React.string} </div>
            )}
            // description
            {switch (title, description) {
            | (Some(_), Some(description)) =>
              <div className="mt-2 text-lg text-f-neutral-secondary-contents">
                {description->React.string}
              </div>
            | (None, Some(description)) =>
              <div className="mt-3 text-xl font-medium"> {description->React.string} </div>
            | _ => React.null
            }}
          </>
        }}
        // buttons
        {switch buttons {
        | Some(buttons) => <div className="flex gap-2 mt-6"> {buttons->React.array} </div>
        | None =>
          if submitLabel->Option.isSome || cancelLabel->Option.isSome {
            <div className="flex gap-2 mt-6">
              {switch cancelLabel {
              | Some(label) =>
                switch cancelType {
                | #primary =>
                  <Formula.Button.Container
                    text={label} color=#primary className="grow" size=#md onClick=?onHide
                  />
                | #gray =>
                  <Formula.Button.Container
                    text={label} color=#"tertiary-gray" className="grow" size=#md onClick=?onHide
                  />
                | #negative =>
                  <Formula.Button.Container
                    text={label}
                    color=#"negative-secondary"
                    className="grow"
                    size=#md
                    onClick=?onHide
                  />
                }
              | _ => React.null
              }}
              {switch submitLabel {
              | Some(label) =>
                switch submitType {
                | #primary =>
                  <Formula.Button.Container
                    text={label} color=#primary className="grow" size=#md onClick=submit
                  />
                | #gray =>
                  <Formula.Button.Container
                    text={label} color=#"tertiary-gray" className="grow" size=#md onClick=submit
                  />
                | #negative =>
                  <Formula.Button.Container
                    text={label}
                    color=#"negative-secondary"
                    className="grow"
                    size=#md
                    onClick=submit
                  />
                }

              | _ => React.null
              }}
            </div>
          } else {
            React.null
          }
        }}
      </div>
    </div>
  }
}
