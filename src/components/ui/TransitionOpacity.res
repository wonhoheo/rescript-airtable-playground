@react.component
let make = (~children, ~isVisible: bool, ~duration) => {
  let (isShow, setIsShow) = React.useState(_ => isVisible)

  React.useEffect2(() => {
    switch isVisible {
    | true => {
        setIsShow(_ => true)
        ()
      }
    | false => {
        let _ = Js.Global.setTimeout(() => {
          setIsShow(_ => false)
        }, duration)
      }
    }
    None
  }, (isVisible, duration))

  <div
    style={{
      animation: `${isVisible ? "fadeIn" : "fadeOut"} ${(duration + 100)
          ->Int.toString}ms ease-in-out`,
    }}>
    {switch isShow {
    | true => children
    | false => React.null
    }}
  </div>
}
