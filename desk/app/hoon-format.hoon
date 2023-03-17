/+  default-agent, verb, dbug, server, hoon-format
|%
+$  card  card:agent:gall
--
::
|%
++  landing-page
  |=  code=(unit [input=tape output=wall])
  =/  input
    ?~  code
      ""
    =/  in  (flop input.u.code)
    |-  ^-  tape
    ?~  in
      ""
    ?:  =('\0a' i.in)
      $(in t.in)
    (flop in)
  =/  output=tape
    ?~  code
      ""
    (of-wall:format output.u.code)
  ^-  manx
  ;html
    ;head
      ;title:"Hoon Format"
    ==
    ;body
      ;p: Enter some hoon code below (no ford runes!)
      ;p
        ; If any code fails to format, please copy the code snippet and
        ;a/"https://github.com/tloncorp/hoon-format/issues/new": submit an issue
      ;form(method "post", enctype "text/plain")
        ;textarea
          =type  "text"
          =rows  "20"
          =cols  "80"
          =name  "code"
          =id    "code"
          =placeholder  "(add 2 3)"
          ; {input}
        ==
        ;br;
        ;button(type "submit"):"Format!"
      ==
      ;pre:code:"{output}"
      ==
    ==
  ==
--
::
%-  agent:dbug
%+  verb  |
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  [[%pass /eyre/connect %arvo %e %connect [~ /apps/hoon-format] dap.bowl]~ this]
::
++  on-save  on-save:def
++  on-load  on-load:def
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %handle-http-request
    =+  !<([id=@ta inbound-request:eyre] vase)
    |^
    :_  this
    ?+    method.request  (give not-found:gen:server)
        %'GET'   (give (manx-response:gen:server (landing-page ~)))
        %'POST'
      ?~  body.request
        (give not-found:gen:server)
      ?.  =('code=' (end [3 5] q.u.body.request))
        (give not-found:gen:server)
      =/  code  (rsh [3 5] q.u.body.request)
      =/  indent
        =|  n=@
        |-  ^-  @
        ?:  =('  ' (cut 4 [n 1] code))
          $(n +(n))
        n
      =/  stripped
        (skip (trip code) |=(char=@tD =('\0d' char)))
      =/  =wall
        =/  gen=(each hoon [@ @])
          =/  vex
            %.  [[1 1] stripped]
            %-  full
            %+  ifix  [gay gay]
            tall:(vang | /sentinel-path/sentinel-path/sentinel-path)
          ?~  q.vex
            [%| p.p.vex q.p.vex]
          [%& p.u.q.vex]
        ?:  ?=(%| -.gen)
          :~  "Syntax error: {<p.gen>}"
              "Remove any ford runes, and ensure the code is one complete rune."
              "Remove any leading \"++ arm\" code."
          ==
        ?~  wall=((p-hoon:hoon-format p.gen) indent | 0)
          ["Failed to format" ~]
        ?~  wall.u.wall
          ~
        wall.u.wall(i (runt [(mul indent 2) ' '] i.wall.u.wall))
      (give (manx-response:gen:server (landing-page `[stripped wall])))
    ==
    ::
    ++  give
      |=  =simple-payload:http
      (give-simple-payload:app:server id simple-payload)
    --
  ==
::
++  on-agent  on-agent:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bowl src.bowl)
  ?+  path  (on-watch:def path)
    [%http-response *]  `this
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    sign-arvo  (on-arvo:def wire sign-arvo)
      [%eyre %bound *]
    ~?  !accepted.sign-arvo
      [dap.bowl 'eyre bind rejected!' binding.sign-arvo]
    [~ this]
  ==
::
++  on-fail   on-fail:def
--
