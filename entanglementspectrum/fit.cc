// delete 'labels' directory from all results dir before running this code

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>
#include <limits.h>

using std::string;
using std::vector;

void
ifexistfile(char *filename)
{
	FILE *fp = fopen(filename, "r");
	if(fp==NULL){ printf("The file does not exist\n"); }
	else{ printf("File exist\n"); fclose(fp); }
}

void
diroperator(string command, char *dirname)
{
	char entire_command[PATH_MAX];
	sprintf(entire_command, "%s %s", command.c_str(), dirname);
	FILE *command_fp = popen(entire_command, "r");
	if(command_fp==NULL){ printf("dir operation failed\n"); }
	else
	{
	sleep(0.5);
	pclose(command_fp);
	}

}

int main()
{
	vector<string> parent_dirs = {"HI_J0.30", "HSF_J0.38", "SF_J0.46"};
	for(int i = 0; i < (int)parent_dirs.size(); i++)
	{
	char parent_dir[PATH_MAX];
	sprintf(parent_dir, "%s", parent_dirs[i].c_str());

	// data: maxdim vs enranglement spectrum
	int maxlabel = 40;
	for(int maxdim = 50; maxdim < 500; maxdim += 50)
	{
		char dirname[PATH_MAX];
		sprintf(dirname, "%s/maxdim_%d", parent_dir, maxdim);

		char filename[PATH_MAX];
		sprintf(filename, "%s/entanglementspectrum_infinite.dat", dirname);
		ifexistfile(filename);

		FILE *fp = fopen(filename, "r");
		int label;
		double value;
		while( fscanf(fp, "%d %le", &label, &value) != EOF )
		{
			printf("label: %d\t value:%.3f\n", label, value);
			if( label > maxlabel ){ break; }

			// make dir
			char dirname_res[PATH_MAX], command[PATH_MAX];
			sprintf(dirname_res, "%s/labels/label_%d", parent_dir, label);
			diroperator("mkdir -p", dirname_res);

			// write to file
			char filename_res[PATH_MAX];
			sprintf(filename_res, "%s/entanglementspectrumVSmaxdim.dat", dirname_res);
			FILE *fp_res = fopen(filename_res, "a");
			if( fp_res == NULL ){ printf("faild to open file\n"); }
			else
			{
			fprintf(fp_res, "%d\t %e\n", maxdim, value);
			fclose(fp_res);
			}
		}
		if(fp!=NULL){ fclose(fp); }
	}

	// fit
	for(int label = 1; label < maxlabel+1; label++)
	{
		char dirname[PATH_MAX], filename[PATH_MAX];
		sprintf(dirname, "%s/labels/label_%d", parent_dir, label);
		sprintf(filename, "%s/entanglementspectrumVSmaxdim.dat", dirname);

		// gnuplot
		FILE *gp = popen("gnuplot -persist", "w");
			if( gp == NULL ){ printf("failed to boot GNUPLOT\n"); }

		fprintf(gp, "set term png font 'Times,18'\n");
		fprintf(gp, "set xrange [0.0:]\n");
		fprintf(gp, "set xlabel '1/{/Symbol c}'\n");
		fprintf(gp, "set ylabel '{/Symbol x} (label i = %d)'\n", label);

		fprintf(gp, "f(x) = a*x+b\n");
		fprintf(gp, "fit f(x) '%s' u (1.0/($1)):2 every ::3 via a,b\n", filename);
		fprintf(gp, "save var '%s/var_fitfunc.var'\n", dirname);
		fprintf(gp, "save functions '%s/fitfunc.func'\n", dirname);
		fprintf(gp, "set print '%s/values_atInfinite.dat'\n", dirname);
		fprintf(gp, "print b\n");
		fprintf(gp, "unset print\n");

		fprintf(gp, "set output '%s/fitting.png'\n", dirname);
		fprintf(gp, "plot '%s' u (1.0/($1)):2  w p pt 7 ps 1.5 lc 'black' t 'data'\n", filename);
		fprintf(gp, "set output '%s/fitting.png'\n", dirname);
		fprintf(gp, "replot f(x) w l lw 2 lc 'red' t 'fit'\n");
		fprintf(gp, "\n");

		pclose(gp);
	}

	// output to file
	for(int label = 1; label < maxlabel+1; label++)
	{
		char dirname[PATH_MAX], filename[PATH_MAX], filename_res[PATH_MAX];
		sprintf(dirname, "%s/labels/label_%d", parent_dir, label);
		sprintf(filename, "%s/values_atInfinite.dat", dirname);
		sprintf(filename_res, "%s/labels/spectrum_atInfiniteBonddim.dat", parent_dir);

		double value;
		FILE *fp = fopen(filename, "r");
		fscanf(fp, "%le", &value);
		fclose(fp);

		fp = fopen(filename_res, "a");
		fprintf(fp, "%d\t %e\n", label, value);
		fclose(fp);
	}

	// plot
	FILE *gp = popen("gnuplot -persist", "w");

	fprintf(gp, "set term png font 'Times,18'\n");
	fprintf(gp, "set xlabel 'label i'\n");
	fprintf(gp, "set ylabel '{/Symbol x}_i ({/Symbol c} = infty)'\n");

	fprintf(gp, "set output '%s/labels/spectrum_atInfiniteBonddim.png'\n", parent_dir);
	fprintf(gp, "plot '%s/labels/spectrum_atInfiniteBonddim.dat' w lp pt 7 ps 1.5 lw 2 lc 'black' t ''\n", parent_dir);


	pclose(gp);

	}



return 0;

}