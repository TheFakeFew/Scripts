return {
    func = function()
        local mem = math.random(1,1e5)
        return [[
      <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">.           .</font>         <font color="rgb(255,127,127)">]]..owner.DisplayName..[[</font>@<font color="rgb(255,127,127)">RoblOS</font>
     <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">:::         :::</font>        ]]..string.rep("-", string.len(owner.DisplayName.."@RoblOS")).."\n"..[[
    <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">:::::       :::::</font>       <font color="rgb(100,255,100)">OS</font>: RoblOS x86_64
    <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">:::::       :::::</font>       <font color="rgb(100,255,100)">Host</font>: A server with ]]..math.random(1,12)..[[ gb of ram
     <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">:::         :::</font>        <font color="rgb(100,255,100)">Kernel</font>: 10.0.22623
      <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">.           .</font>         <font color="rgb(100,255,100)">Uptime</font>: ]]..math.random(1,5)..[[ saturday(s)
                            <font color="rgb(100,255,100)">Packages</font>: ]]..math.random(1,9999)..[[ (toolbox)
                            <font color="rgb(100,255,100)">Shell</font>: bash 5.1.16
                            <font color="rgb(100,255,100)">Resolution</font>: 640x480 
                            <font color="rgb(100,255,100)">DE</font>: Marketplace
                            <font color="rgb(100,255,100)">WM</font>: Explorer
  <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">.                  .::.</font>   <font color="rgb(100,255,100)">WM Theme</font>: Custom
 <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">:::.               .:::.</font>   <font color="rgb(100,255,100)">CPU</font>: Intel Pentium
 <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">.::::             ..::.</font>    <font color="rgb(100,255,100)">GPU</font>: NVidia GeForce 256
  <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">.::::.         .::::.</font>     <font color="rgb(100,255,100)">Memory</font>: ]]..math.random(1,mem)..[[MiB / ]]..mem..[[MiB
    <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">:::::.     .:::::</font>
     <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">::::::::::::::. </font>                 
       <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">::::::::::.</font>
          <font color="rgb(]]..math.random(70,255)..[[,]]..math.random(70,255)..[[,]]..math.random(70,255)..[[)">.::::</font>]]
    end,
    description = "fetches system information"
}