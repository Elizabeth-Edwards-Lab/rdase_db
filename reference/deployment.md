# Deployment

# Blast+ installation
## ubuntu
apt update
apt upgrade
apt install ncbi-blast+-legacy
apt install ncbi-blast+

note: ubuntu doesn't need to worry about the issue from MacOS since the blastall program can be installed 
through apt install ncbi-blast+-legacy

if you want to use ncbi-blast+ and perl script of legacy_blast, then
you don't need to worry about legacy_blast's default file path
but you need to change the path at config/initializers/blast.rb

def make_command_line
  path = "//usr/local/ncbi/blast/bin"  # CHANGE ME
  cmd = make_command_line_options
  cmd.unshift @blastall
  cmd.unshift "#{path}/legacy_blast.pl"    # ADDED
  cmd.push "--path"                        # ADDED
  cmd.push path                            # ADDED
  cmd
end

I guess have to run some sort script to replace the blast.rb for every deployment

## MacOS
Below instruction is for using old blastall program 
BioRuby still use blastall so currently have to use legacy_blast.pl

Use legacy_blast.pl in /usr/local/ncbi/blast/bin for ruby on rails
then override following function 
To override function from gem, create new file (with same name as original file) in config/initializers
And copy everything except making customized modification for overriding
See reference: https://stackoverflow.com/questions/580314/overriding-a-module-method-from-a-gem-in-rails

module Bio
  class Blast
    def make_command_line
      path = "/path/to/ncbi-blast-2.9.0+/bin"  # CHANGE ME
      cmd = make_command_line_options
      cmd.unshift @blastall
      cmd.unshift "#{path}/legacy_blast.pl"    # ADDED
      cmd.push "--path"                        # ADDED
      cmd.push path                            # ADDED
      cmd
    end
  end
end

program = "blastn"
blast_options = "-m 8"

blaster = Bio::Blast.local(program, "#{Rails.root}/index/blast/#{database}", blast_options)
report = blaster.query(@sequence.seq)

IMPORTANT:
legacy_blast.pl use default /usr/bin for all executable blast program.
if use legacy_blast.pl, should modify the legacy_blast.pl

# how to deploy new changes on ubuntu
bundle exec cap production deploy # pull changes from repo
// change blast.rb and possible restart puma.sh
bundle exec cap production deploy:restart # apply the changes from blast.rb

If the system is under ubuntu, the following file should be modified
1. config/initializers/blast.rb => change back to original code because blastall exist in ubuntu
2. database.yml => change the location of msyql.sock due to installation place

# mailer / contact form
- Set action_mailer to/from address and SMTP settings accordingly in config/environments/*