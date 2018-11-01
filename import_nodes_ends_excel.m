# This script is a function to extract data from an image as excel data
function [number_nodes,number_ends,i]=import_nodes_ends_excel(s,i);
rgb=imread(s);
main=removemainnodes(s);   
[number_nodes,number_ends]=count_node_end(main);
channel = ddeinit('excel','node_ends_rootII.xls');
rc1=ddepoke(channel, ['r',num2str(i),'c2'],number_nodes);
rc2 = ddepoke(channel, ['r',num2str(i),'c3'],number_ends);

rc3 = ddepoke(channel, ['r',num2str(i),'c1'], (s));
i=i+1;

save numlines i;
