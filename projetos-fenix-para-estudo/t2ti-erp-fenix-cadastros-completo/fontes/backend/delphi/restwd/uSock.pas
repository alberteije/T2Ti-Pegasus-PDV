Unit uSock;
{$IFDEF FPC}
{$IFDEF Linux}
  {$mode objfpc}{$H+}
{$ELSE}
{$MODE Delphi}
{$ENDIF}
{$ENDIF}

Interface

{$IFDEF Linux}

 uses sockets, baseunix, unix;
const
  IPPROTO_IP = 0;
  IF_NAMESIZE = 16;
  SIOCGIFCONF = $8912;

type
{$packrecords c}
  tifr_ifrn = record
    case integer of
      0: (ifrn_name: array [0..IF_NAMESIZE - 1] of char);
  end;

  tifmap = record
    mem_start: PtrUInt;
    mem_end: PtrUInt;
    base_addr: word;
    irq: byte;
    dma: byte;
    port: byte;
  end;

  PIFrec = ^TIFrec;

  TIFrec = record
    ifr_ifrn: tifr_ifrn;
    case integer of
      0: (ifru_addr: TSockAddr);
      1: (ifru_dstaddr: TSockAddr);
      2: (ifru_broadaddr: TSockAddr);
      3: (ifru_netmask: TSockAddr);
      4: (ifru_hwaddr: TSockAddr);
      5: (ifru_flags: word);
      6: (ifru_ivalue: longint);
      7: (ifru_mtu: longint);
      8: (ifru_map: tifmap);
      9: (ifru_slave: array[0..IF_NAMESIZE - 1] of char);
      10: (ifru_newname: array[0..IF_NAMESIZE - 1] of char);
      11: (ifru_data: pointer);
  end;

  TIFConf = record
    ifc_len: longint;
    case integer of
      0: (ifcu_buf: pointer);
      1: (ifcu_req: ^tifrec);
  end;

  
     tNetworkInterface     = Record
                               ComputerName          : String;
                               AddrIP                : String;
                               SubnetMask            : String;
                               AddrNet               : String;
                               AddrLimitedBroadcast  : String;
                               AddrDirectedBroadcast : String;
                               IsInterfaceUp         : Boolean;
                               BroadcastSupport      : Boolean;
                               IsLoopback            : Boolean;
                             end;

     tNetworkInterfaceList = Array of tNetworkInterface;

  Function GetNetworkInterfaces (Var aNetworkInterfaceList : tNetworkInterfaceList): Boolean;
{$ELSE}
  Uses Windows, Winsock;
{ Unit to identify the network interfaces
  This code requires at least Win98/ME/2K, 95 OSR 2 or NT service pack #3
  as WinSock 2 is used (WS2_32.DLL) }


// Constants found in manual on non-officially documented M$ Winsock functions
Const SIO_GET_INTERFACE_LIST = $4004747F;
      IFF_UP                 = $00000001;
      IFF_BROADCAST          = $00000002;
      IFF_LOOPBACK           = $00000004;
      IFF_POINTTOPOINT       = $00000008;
      IFF_MULTICAST          = $00000010;


Type SockAddr_Gen          = Packed Record
                               AddressIn             : SockAddr_In;
                               Padding               : Packed Array [0..7] of Byte;
                             end;

     Interface_Info        = Record
                               iiFlags               : u_Long;
                               iiAddress             : SockAddr_Gen;
                               iiBroadcastAddress    : SockAddr_Gen;
                               iiNetmask             : SockAddr_Gen;
                             end;

     tNetworkInterface     = Record
                               ComputerName          : String;
                               AddrIP                : String;
                               SubnetMask            : String;
                               AddrNet               : String;
                               AddrLimitedBroadcast  : String;
                               AddrDirectedBroadcast : String;
                               IsInterfaceUp         : Boolean;
                               BroadcastSupport      : Boolean;
                               IsLoopback            : Boolean;
                             end;

     tNetworkInterfaceList = Array of tNetworkInterface;


Function WSAIoctl (aSocket              : TSocket;
                   aCommand             : DWord;
                   lpInBuffer           : Pointer;
                   dwInBufferLen        : DWord;
                   lpOutBuffer          : Pointer;
                   dwOutBufferLen       : DWord;
                   lpdwOutBytesReturned : LPDWord;
                   lpOverLapped         : Pointer;
                   lpOverLappedRoutine  : Pointer) : Integer; stdcall; external 'WS2_32.DLL';

Function GetNetworkInterfaces (Var aNetworkInterfaceList : tNetworkInterfaceList): Boolean;
{$ENDIF}


implementation


{$IFDEF LINUX}

function GetNetworkInterfaces(var aNetworkInterfaceList: tNetworkInterfaceList
  ): Boolean;
var
  i, n, nr,Sd: integer;
  buf: array[0..1023] of byte;
  ifc: TIfConf;
  ifp: PIFRec;
  names: string;
begin
  sd := fpSocket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
  //Result := '';
  if (sd < 0) then
    exit;
  try
    ifc.ifc_len := Sizeof(Buf);
    ifc.ifcu_buf := @buf;
    if fpioctl(sd, SIOCGIFCONF, @ifc) < 0 then
      Exit;
    n := ifc.ifc_len;
    i := 0;
    names := '';
    nr:= trunc((n/sizeof(TIFrec)));
    SetLength(aNetworkInterfaceList,nr);
    nr:=0;
    while (i < n) do
    begin
      ifp := PIFRec(PByte(ifc.ifcu_buf) + i);
      names := names + ifp^.ifr_ifrn.ifrn_name + ' ';
     // if i > 0 then
        //Begin
        aNetworkInterfaceList[nr].AddrIP:=NetAddrToStr(ifp^.ifru_addr.sin_addr);
       // end;
        //Result := Result + ',';
      //Result := Result + ifp^.ifr_ifrn.ifrn_name +' : '+NetAddrToStr(ifp^.ifru_addr.sin_addr)+' aa: '+NetAddrToStr(ifp^.ifru_netmask.sin_addr);
      i := i + sizeof(TIFrec);
      inc(nr);
    end;
     result:=true;
  finally
    //fileClose(sd);
  end;

end;

{$ELSE}


Function GetNetworkInterfaces (Var aNetworkInterfaceList : tNetworkInterfaceList): Boolean;
// Returns a complete list the of available network interfaces on a system (IPv4)
// Copyright by Dr. Jan Schulz, 23-26th March 2007
// This version can be used for free and non-profit projects. In any other case get in contact
// Written with information retrieved from MSDN
// www.code10.net
Var aSocket             : TSocket;
    aWSADataRecord      : WSAData;
    NoOfInterfaces      : Integer;
    NoOfBytesReturned   : u_Long;
    InterfaceFlags      : u_Long;
    NameLength          : DWord;
    pAddrIP             : SockAddr_In;
    pAddrSubnetMask     : SockAddr_In;
    pAddrBroadcast      : Sockaddr_In;
    DirBroadcastDummy   : In_Addr;
    NetAddrDummy        : In_Addr;
    Buffer              : Array [0..30] of Interface_Info;
    i                   : Integer;
Begin
  Result := False;
  SetLength (aNetworkInterfaceList, 0);

  // Startup of old the WinSock
  // WSAStartup ($0101, aWSADataRecord);

  // Startup of WinSock2
  WSAStartup(MAKEWORD(2, 0), aWSADataRecord);

  // Open a socket
  aSocket := Socket (AF_INET, SOCK_STREAM, 0);

  // If impossible to open a socket, not worthy to go any further
  If (aSocket = INVALID_SOCKET) THen Exit;

  Try
    If WSAIoCtl (aSocket, SIO_GET_INTERFACE_LIST, NIL, 0,
                 @Buffer, 1024, @NoOfBytesReturned, NIL, NIL) <> SOCKET_ERROR THen
    Begin
      NoOfInterfaces := NoOfBytesReturned  Div SizeOf (Interface_Info);
      SetLength (aNetworkInterfaceList, NoOfInterfaces);

      // For each of the identified interfaces get:
      For i := 0 to NoOfInterfaces - 1 do
      Begin

        With aNetworkInterfaceList[i] do
        Begin

          // Get the name of the machine
          NameLength := MAX_COMPUTERNAME_LENGTH + 1;
          SetLength (ComputerName, NameLength)  ;
          If Not GetComputerName (PChar (Computername), NameLength) THen ComputerName := '';

          // Get the IP address
          pAddrIP                  := Buffer[i].iiAddress.AddressIn;
          AddrIP                   := string(inet_ntoa (pAddrIP.Sin_Addr));

          // Get the subnet mask
          pAddrSubnetMask          := Buffer[i].iiNetMask.AddressIn;
          SubnetMask               := string(inet_ntoa (pAddrSubnetMask.Sin_Addr));

          // Get the limited broadcast address
          pAddrBroadcast           := Buffer[i].iiBroadCastAddress.AddressIn;
          AddrLimitedBroadcast     := string(inet_ntoa (pAddrBroadcast.Sin_Addr));

          // Calculate the net and the directed broadcast address
          NetAddrDummy.S_addr      := Buffer[i].iiAddress.AddressIn.Sin_Addr.S_Addr;
          NetAddrDummy.S_addr      := NetAddrDummy.S_addr And Buffer[i].iiNetMask.AddressIn.Sin_Addr.S_Addr;
          DirBroadcastDummy.S_addr := NetAddrDummy.S_addr Or Not Buffer[i].iiNetMask.AddressIn.Sin_Addr.S_Addr;

          AddrNet                  := string(inet_ntoa ((NetAddrDummy)));
          AddrDirectedBroadcast    := string(inet_ntoa ((DirBroadcastDummy)));

          // From the evaluation of the Flags we receive more information
          InterfaceFlags           := Buffer[i].iiFlags;

          // Is the network interface up or down ?
          If (InterfaceFlags And IFF_UP) = IFF_UP THen IsInterfaceUp := True
                                                  Else IsInterfaceUp := False;

          // Does the network interface support limited broadcasts ?
          If (InterfaceFlags And IFF_BROADCAST) = IFF_BROADCAST THen BroadcastSupport := True
                                                                Else BroadcastSupport := False;

          // Is the network interface a loopback interface ?
          If (InterfaceFlags And IFF_LOOPBACK) = IFF_LOOPBACK THen IsLoopback := True
                                                              Else IsLoopback := False;
        end;
      end;
    end;
  Except
    //Result := False;
  end;

  // Cleanup the mess
  CloseSocket (aSocket);
  WSACleanUp;
  Result := True;
end;
{$ENDIF}

end.
