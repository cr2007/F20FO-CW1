#import "lib.typ": template
#import "@preview/oxifmt:0.2.1": strfmt

#let data = yaml("metadata.yml")

#set line(length: 100%)
#set document(
  author: strfmt("{} {}", data.studentFirstName, data.studentLastName),
  title: strfmt("{} {}", data.courseCode, data.courseworkTitle),
)

#show: template.with()

#align(horizon + center)[
  #set text(font: "Dubai", 11pt)
  #show link: it => text(fill: rgb("0563C1"), it)

  #let email = strfmt("{}@hw.ac.uk", data.studentEmail)

  #text(size: 28pt, weight: "medium", strfmt("{} {}", data.courseCode, data.courseworkTitle))

  #data.studentFirstName #data.studentLastName \
  BSc. Computer Science (Hons.) \
  #link(strfmt("mailto:{}", email))[#email] \ \

  #text(size: 18pt, strong[
    OneDrive Video Link: #link("mailto:f20fo@csk.fyi?subject=Video%20Demo%20-%20F20FO%20Coursework%201", strfmt("F20FO-CW1_{}.mp4", data.studentEmail))
  ])

  #v(11pt)

  #set align(left)

  #outline(indent: 1em)
]

#pagebreak()
#set align(left)
#set text(font: "Calibri")

= Introduction

For this endeavor, a prototype virtual digital forensics (DF) lab was created to explore the field of digital forensics.
Using the Oracle VM VirtualBox Software, two virtual machines were deployed: one running Ubuntu 22.04.4 LTS and the
other running Windows 10 Enterprise Evaluation. Each machine is equipped with 4GB of memory. The Windows virtual machine
is allocated 80MB of video memory, whereas the Linux machine is allocated 40MB of video memory.

#figure(
  caption: "System information of both the Virtual Machines",
  rect(stroke: 0.75pt, image(format: "png", height: 7.64cm, "images/VM_System-Information.png")),
)\

The virtual machines establish effective communication through a combination of NAT and Host-Only Adapter
configurations. This configuration facilitates seamless interaction between the machines. Within the Windows VM,
additional measures were necessary to enable ICMP request handling @ComputerPing. In the Windows Firewall settings,
Inbound and Outbound rules were created to permit ICMP requests. This adjustment ensures the Windows Virtual Machine's
ability to respond to pings from other virtual machines.

= Setting up Digital Forensics Lab

During the setup of the Digital Forensics Lab, two digital forensic tools were installed on each virtual machine. The
installed tools encompassed functionalities such as password cracking, network analysis, and file recovery.

On the Windows virtual machine, KickassUndelete (a file recovery tool) and NetworkMiner (a network forensic tool) were
installed. While on the other hand, Wireshark (a network protocol analyzer) and John the Ripper (a password cracking
tool) were configured on the Linux virtual machine.

#pagebreak()

= Windows VM

== KickassUndelete

KickassUndelete, an open-source file recovery tool designed for Windows, is used for identifying deleted files across
hard drives, flash drives, or SD Cards, aiding their retrieval. Compatible with both FAT and NTFS file systems, it
features a user-friendly interface for ease of operation.

KickassUndelete offers several advantages. It employs color-coding to indicate file status, enhancing user
comprehension. Additionally, its intuitive interface, highlighted by a prominent Scan button, ensures ease of operation.
However, limitations include support solely for NTFS and FAT file systems, constraining its applicability to a narrow
range of hard drives for file recovery. Moreover, the software is prone to occasional corruption.

== NetworkMiner

#underline[NetworkMiner] is a robust open-source network forensics tool designed to extract artifacts from captured
network traffic stored in PCAP files. Developed primarily in C\#, it is optimized for Windows but can also operate on
Linux systems. Widely favored by incident response teams and law enforcement agencies, #underline[NetworkMiner] proves
to be an asset in forensic investigations.

#underline[NetworkMiner] proves proficient in extracting artifacts from network traffic, aiding evidence collection in
investigations by retrieving files, images, emails, and passwords. It compiles detailed IP address information,
facilitating network host inventory creation and operating system identification. However, its specialized nature limits
broader applicability beyond digital forensic tasks, necessitating user understanding of specific use cases.
Additionally, NetworkMiner, like other network forensic tools, may strain system resources, potentially causing
slowdowns during analysis of extensive network traffic. Processing and analyzing large #strong[P]acket #strong[CAP]ture
(PCAP) files may also entail lengthy durations.

= Linux VM (Ubuntu)

In the Ubuntu virtual machine, tool installation primarily occurs through the command line interface, in contrast to the
Windows operating system. All tasks, including downloading, extracting compressed packages, configuring, and installing
tools, are performed via the command line interface. The installed forensic tools in this virtual machine are #underline[John the Ripper],
a password-cracking tool, and #underline[Wireshark], a network packet analyzer tool.

== John the Ripper

John the Ripper is an open-source password-cracking software tool utilized to assess password strength across diverse
systems (John the Ripper password cracker). Employing techniques like dictionary attacks, brute-force attacks, and
rainbow tables, it aims to expose vulnerabilities. While advantageous for Digital Forensic Examiners, employing John the
Ripper entails inherent limitations and risks.

Firstly, John the Ripper can crack over 411 types of passwords, spanning from Unix passwords to databases and Wi-Fi
passwords. Additionally, it notably decreases the time needed to access password-protected files or accounts, enabling
examiners to allocate attention to other investigative avenues. Furthermore, John the Ripper supports a diverse array of
hash algorithms, including MD5, SHA-1, and SHA-256, rendering it compatible with various systems and applications.

Despite the many advantages of having a password cracking tool, it is also a tool that has serious legal consequences
for violating the any privacy laws and professional codes of conduct. While it is effective for plaintext and unsalted
hashes, it can become ineffective when dealing with salted hashes or large salt values, thereby increasing overall
complexity. Finally, it may also not be compatible with all encryption methods or password storage mechanisms
encountered in forensic investigations.

\
== Wireshark

#strong(underline[Wireshark]) is hailed as “the world’s foremost network protocol analyzer” @Wireshark. This tool
empowers digital forensic examiners to delve deep into network packets, scrutinize network traffic, and extract
pertinent data crucial for digital investigations. Boasting a myriad of features, Wireshark offers packet capturing
capabilities, robust filtering options, live packet capture functionality, and facilitates the export of captured data
into diverse formats, enabling comprehensive analysis and streamlined reporting processes.

Wireshark offers significant advantages as a forensic tool. Firstly, it facilitates thorough analysis of network
packets, aiding in comprehension of communication patterns, anomaly detection, and event reconstruction. Secondly, its
robust filtering features empower examiners to hone in on specific traffic types or swiftly extract pertinent data.
Lastly, Wireshark enables seamless file extraction from #strong[P]acket #strong[CAP]ture (PCAP) files, enhancing
investigative efficiency.

However, just like any major forensic tool, there are disadvantages with using Wireshark. Firstly, the tool can be
overly complex and overwhelming for inexperienced users, even those with a strong understanding of networking concepts.
Running Wireshark can also be very time-consuming and resource-intensive, especially for tasks such as capturing network
traffic data and examining large packet captures. One final thing to note about Wireshark is that while it provides
detailed information about network packets, it may not always provide a complete picture of an incident, especially when
examining it in isolation. It lacks context about the broader environment surrounding the network activity.

Despite its utility, Wireshark presents certain drawbacks for forensic examination. Firstly, its complexity can prove
daunting for inexperienced users, including those well-versed in networking fundamentals. Moreover, utilizing Wireshark
can consume critical time and resources, particularly during tasks such as capturing network data and analyzing
extensive packet captures. Additionally, while Wireshark offers detailed packet information, it may not always furnish a
comprehensive understanding of an incident, particularly when assessed in isolation, as it lacks contextual information
about the broader network environment @WiresharkReview.

#line()

#heading[Illustrative Examples]

#heading(level: 2)[Wireshark - Ubuntu VM]

#heading(level: 3, "1. Port Scan")

Wireshark presents a crucial capability to identify port scans when analyzing capture files. Port scanning, a technique
aimed at discerning open and active ports on a computer or network, serves to assess network security and expose
potential vulnerabilities.

In the instance at hand, we leverage a capture file utilized for instructional purposes @WiresharkStatisticsTutorial.
Upon opening the PCAP file in Wireshark, over 33,000 packets are revealed, making it impractical to view each individual
packet.

#figure(
  caption: [A Wireshark session of a PCAP file @WiresharkStats],
  rect(stroke: 0.75pt, image(height: 7.18cm, "images/wireshark/Wireshark_Statistics_PCAP.png")),
)

To streamline analysis, navigating to the #strong[Statistics] menu and accessing the #strong(underline[Conversations]) tab
unveils a list of interactions, particularly those characterized by a high packet count and low byte count. Such
occurrences typically denotes a short-lived conversation, indicating the presence of port scans.\
Examining conversations where the source port remains constant while the destination port iterates through a range of
common ports strongly suggests a port scan within the network.

\ #figure(
  caption: "A list of conversations captured within the PCAP file",
  rect(stroke: 0.75pt, image(height: 6.18cm, "images/wireshark/Wireshark_Conversations-Captured_PCAP.png")),
)

Leveraging Wireshark, we can scrutinize network packets effectively, pinpointing potential threat actors exploiting unused ports to gain unauthorized entry into systems.

#heading(level: 3, "2. Extracting files from Pocker CAPtures (PCAP)")

Wireshark offers the capability to extract files from unencrypted protocols, a vital function in cybersecurity for isolating traffic segments for further analysis. In this instance, a sample PCAP file is utilized for educational purposes @WiresharkTutorial.

#figure(
  caption: [A Wireshark window displaying the contents of this PCAP file @WiresharkFiles],
  rect(stroke: 0.75pt, image(height: 7.81cm, "images/wireshark/Wireshark_PCAP-Content-Display.png")),
)

Upon loading the capture file into Wireshark, it is imperative to ensure that the "Allow sub dissector to reassemble TCP streams" option within the TCP protocol preferences is enabled.
This step instructs Wireshark to reassemble packets into a unified stream, facilitating file extraction.

#figure(
  caption: [A screenshot showing that the relevant option has been enabled],
  rect(stroke: 0.75pt, image(height: 5.68cm, "images/wireshark/Wireshark_Screenshot_Relevent-Options.png")),
)

Subsequently, navigating to File > Export Objects > and selecting the HTTP option reveals the list of HTTP objects detected within the PCAP file.

#figure(
  caption: [A screenshot of listing all the HTTP objects that Wireshark found],
  rect(stroke: 0.75pt, image(height: 8.29cm, "images/wireshark/Wireshark_HTTP-Objects_Listed.png")),
)

As depicted in the figure below, two HTTP objects were captured within the packet in an unencrypted network, enabling users to download and examine the files locally.

#figure(
  caption: [A list of HTTP objects found by Wireshark],
  rect(stroke: 0.75pt, image(height: 8.29cm, "images/wireshark/Wireshark_HTTP-Objects-List_Found.png")),
)

This functionality proves invaluable in forensic investigations, particularly when scrutinizing potentially malicious files transmitted across unencrypted networks.

=== 3. Mapping the location of IP Addresses

#grid(
  columns: 2,
  column-gutter: 1em,
  [
    In addition to its packet analysis and file extraction capabilities, Wireshark offers IP address location mapping functionality. In this demonstration, we utilize GeoIP databases @GeoLite2 designed for this purpose.

    Upon installation of the databases, Wireshark is configured to access the directory containing these database files, which store information such as the source country, city, latitude, and longitude coordinates associated with each IP address within the packet.

    Once configured, Wireshark displays an additional attribute, as depicted, indicating the country and city associated with each IP address.

    In an ideal scenario, this feature provides valuable insight into the geographic origin of IP addresses involved in network activity, unless thwarted by malicious actors employing spoofing techniques to conceal their actual location.
  ],
  figure(
    caption: [A list of HTTP objects found by Wireshark],
    rect(stroke: 0.75pt, image("images/wireshark/Wireshark_Extra-Attribute_Country.png")),
  ),
)

#line()

== NetworkMiner - Windows VM

=== 4. Fingerprinted Operating System (OS)

When monitoring traffic in NetworkMiner or examining a specific packet capture file, the tool employs fingerprint recognition to provide detailed host information. This includes data such as packet counts, MAC addresses, vendor names, and other relevant details.

#figure(
  caption: "NetworkMiner examining the packet capture file, seeing the Fingerprint OS",
  rect(stroke: 0.85pt, image(height: 8.51cm, "images/network-miner/NetworkMiner_PCAP-File_Fingerprint-OS.png")),
)
#figure(
  caption: "NetworkMiner examining the packet capture file, seeing the Fingerprint OS",
  rect(stroke: 0.85pt, image(height: 8.51cm, "images/network-miner/NetworkMiner_PCAP-File_Fingerprint-OS.png")),
)

As illustrated in the diagram above, utilizing the same PCAP file referenced in previous examples reveals three distinct hosts in the list.
Notably, one host is identified as running Windows, while the operating systems of the other two hosts are labeled as Unknown.

#figure(
  caption: "The images from this file shown as a thumbnail that have been extracted by NetworkMiner",
  rect(stroke: 0.85pt, image(height: 3.51cm, "images/network-miner/NetworkMiner_Thumbnail-Contents.png")),
)

This feature of NetworkMiner enables digital forensic examiners to gain insights into the composition of the network, identifying the operating systems utilized by each host.
Such information can be instrumental in understanding the network environment and identifying potential vulnerabilities or suspicious activity.

Furthermore, NetworkMiner's ability to automatically categorize hosts based on their operating system enhances the efficiency of forensic investigations, allowing examiners to prioritize their analysis efforts.

#line()

= Conclusion

In conclusion, the establishment of two virtual machines for a prototype digital forensics lab has been successfully accomplished to support the company's investigative needs.
Both a Linux and a Windows environment were configured to facilitate seamless communication between them.
Additionally, the installation and evaluation of two digital forensics tools on each machine have been thoroughly documented, including their respective advantages and disadvantages, drawing from both existing literature and practical observations.

This initiative lays a solid foundation for future digital forensic endeavors within the organization, enhancing its capacity to effectively investigate and mitigate cybersecurity incidents.

#line()


// --------------------------------------------
#bibliography("bibliography.bib", style: "harvard-cite-them-right")
\
#line()
#line()
