% Get all PDF files in the current folder
fnum = 40;
lol = 'E:\eBooks and Documents\mydoc\My Creation\projects\LFD Face Recognition\TrainingFaces - Copy';
lol1 = [lol '\s' num2str(fnum) '\'];

files = dir([lol1 '*.pgm']);
% Loop through each
for id = 1:length(files)
    % Get the file name (minus the extension)
    [~, f] = fileparts(files(id).name);

      % Convert to number
      num = str2num(f);
      if ~isnan(num)
          % If numeric, rename
          oldname = [lol1 files(id).name];
          newname =  [num2str(((fnum-1)*10)+num) '.pgm'];
          dos(['rename "' oldname '" "' newname '"']);
      end

end