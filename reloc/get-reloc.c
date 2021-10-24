/* Generates relocation information from two Atari executables ad different
 * loafing address.
 *
 * CC0 (Public domain). */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef unsigned char u8;

// Segment of binary load data
struct segment {
    int num;
    int start;
    int end;
    u8 data[65536];
};

static int read_word(FILE *f)
{
    int a = getc(f);
    int b = getc(f);
    if( a == EOF || b == EOF )
        return -1;
    return (a & 0xFF) + 256 * (b & 0xFF);
}

static void write_seg(const char *name, FILE *f, int snum, struct segment *s)
{
    if( !snum )
    {
        putc( 0xFF, f );
        putc( 0xFF, f );
    }
    fprintf(stderr, "%s: seg %d: $%04x-$%04x\n", name, snum, s->start, s->end);
    putc( s->start & 0xFF, f);
    putc( s->start >> 8, f);
    putc( s->end & 0xFF, f);
    putc( s->end >> 8, f);
    fwrite( s->data, s->end - s->start + 1, 1, f);
    fflush(f);
}

static int read_seg(const char *name, FILE *f, int snum, struct segment *s)
{
    int start = read_word(f);
    if( !snum && start != 0xFFFF )
    {
        fprintf(stderr,"%s: missing FFFF header.\n", name);
        return -1;
    }

    if( start == 0xFFFF )
        start = read_word(f);

    if( start < 0 )
        return 0;

    int end = read_word(f);
    int len = end - start + 1;
    if( len < 1 )
    {
        fprintf(stderr, "%s: invalid segment %d ($%04x-$%04x)\n", name, snum, start, end);
        return -1;
    }

    if( len != fread(s->data, 1, len, f) )
    {
        fprintf(stderr, "%s: error reading segment %d data.\n", name, snum);
        return -1;
    }

    s->start = start;
    s->end = end;
    return snum + 1;
}

static int read_files(const char *name1, const char *name2, int dif, int *table, int *num)
{
    int seg = 0;

    // Open both files
    FILE *f1 = fopen(name1, "rb");
    if( !f1 )
    {
        fprintf(stderr,"%s: can't open base file.\n", name1);
        return -1;
    }
    FILE *f2 = fopen(name2, "rb");
    if( !f2 )
    {
        fprintf(stderr,"%s: can't open comparison file.\n", name2);
        return -1;
    }

    while(1)
    {
        int start1 = read_word(f1);
        if( !seg && start1 != 0xFFFF )
        {
            fprintf(stderr,"%s: missing FFFF header.\n", name1);
            fclose(f1);
            fclose(f2);
            return -1;
        }
        if( start1 == 0xFFFF )
        {
            if( read_word(f2) != 0xFFFF )
                fprintf(stderr,"%s: missing FFFF header.\n", name2);
            start1 = read_word(f1);
        }
        int start2 = read_word(f2);
        if( start1 < 0 && start2 < 0 )
            break;
        if( start1 != start2 )
        {
            if( dif && (start1 - start2 != dif) )
            {
                fprintf(stderr, "%s: error at block %04x, unexpected difference %04x.\n",
                        name2, start1, start1-start2);
                return -1;
            }
            if( !dif )
            {
                dif = start1 - start2;
                fprintf(stderr, "%s: detected difference of %04x\n", name2, dif);
                if( dif & 0xFF )
                {
                    fprintf(stderr, "%s: error, difference must be multiple of 256\n", name1);
                    return -1;
                }
            }
        }
        // Simulate loading both at the same address
        int end1 = read_word(f1);
        int end2 = read_word(f2);
        if( end1 < 0 )
        {
            fprintf(stderr,"%s: truncated header.\n", name1);
            fclose(f1);
            fclose(f2);
            return -1;
        }
        if( end2 < 0 )
        {
            fprintf(stderr,"%s: truncated header.\n", name2);
            fclose(f1);
            fclose(f2);
            return -1;
        }
        if( end1 < start1 )
        {
            fprintf(stderr,"%s: invalid header $%04x - $%04x\n",
                    name1, start1, end1);
            fclose(f1);
            fclose(f2);
            return -1;
        }
        if( end2 < start2 )
        {
            fprintf(stderr,"%s: invalid header $%04x - $%04x\n",
                    name2, start2, end2);
            fclose(f1);
            fclose(f2);
            return -1;
        }
        int len = end1 - start1 + 1;
        if( end2 - start2 + 1 != len )
        {
            fprintf(stderr,"%s: differing lengths $%04x / $%04x\n",
                    name2, len, end2 - start2 + 1);
            fclose(f1);
            fclose(f2);
            return -1;
        }
        fprintf(stderr,"%s: $%04x-$%04x / $%04x-$%04x\n", name1, start1, end1,
                start2, end2);
        while(len--)
        {
            int c1 = getc(f1);
            int c2 = getc(f2);
            if( c1 < 0 )
            {
                fprintf(stderr,"%s: truncated file\n", name1);
                fclose(f1);
                fclose(f2);
                return -1;
            }
            if( c2 < 0 )
            {
                fprintf(stderr,"%s: truncated file\n", name2);
                fclose(f1);
                fclose(f2);
                return -1;
            }
            if( c1 != c2 )
            {
                if( (c1 - c2) != (dif>>8) )
                {
                    fprintf(stderr,"%s: difference error at %04x\n", name1, start1);
                    fclose(f1);
                    fclose(f2);
                    return -1;
                }
                table[*num] = start1;
                (*num)++;
            }
            start1++;
            start2++;
        }
        seg++;
    }
    fclose(f1);
    fclose(f2);
    return 0;
}

static int write_output(const char *i_name, const char *o_name, int table_addr,
                        int *table, int num)
{
    // Open both files
    FILE *fi = fopen(i_name, "rb");
    if( !fi )
    {
        fprintf(stderr,"%s: can't open base file.\n", i_name);
        return -1;
    }

    // Read all input segments, joining segments if possible
    int snum = 0;
    struct segment *slist = malloc(sizeof(struct segment) * 256);

    while(1)
    {
        struct segment *s = &slist[snum];
        int e = read_seg(i_name, fi, snum, s);
        if( !e )
            break;
        if( e < 0 || snum > 255 )
        {
            if( snum > 255 )
                fprintf(stderr, "%s: too many segments\n", i_name);
            fclose(fi);
            free(slist);
            return -1;
        }
        snum++;
    }
    fclose(fi);

    // Create a segment with the table data
    struct segment tab;
    tab.start = table_addr;
    tab.end = table_addr + num * 2 - 1;
    if( tab.start < 256 || tab.end > 65535 )
    {
        fprintf(stderr,"%s: invalid table address or length: $%0x-$%04x\n",
                i_name, tab.start, tab.end);
        free(slist);
        return -1;
    }
    for(int i=0; i<num; i++)
    {
        tab.data[i*2] = table[i] & 0xFF;
        tab.data[i*2+1] = table[i] >> 8;
    }

    // Insert segment into table at the proper position
    int i;
    for(i=1; i<snum; i++)
    {
        if( slist[i].start > tab.end )
            break;
    }
    fprintf(stderr, "%s: inserting relocation table segment %d at $%04x\n", o_name,
            i, table_addr);
    if( i < snum )
        memmove(&slist[i+1], &slist[i], (snum - i) * sizeof(slist[0]));
    slist[i] = tab;
    snum++;

    // Join segments that are near enough
    int j;
    for(i=1, j=0; i<snum; i++)
    {
        // Segment J is the current "output" segment, segment "I" is the one to check
        struct segment *l = &slist[j];
        struct segment *s = &slist[i];
        int off = s->start - l->end;
        if(off > 0 && off <= 4 )
        {
            fprintf(stderr, "%s: joining segments %d and %d\n", o_name, i, j);
            // Join segments, adding zeroes between
            off = l->end - l->start + 1;
            while(l->end + 1 != s->start)
            {
                l->data[off++] = 0;
                l->end ++;
            }
            memcpy(&(l->data[off]), &(s->data[0]), s->end - s->start + 1);
            l->end = s->end;
        }
        else
        {
            j++;
            slist[j] = slist[i];
        }
    }
    snum = j+1;

    // Write resulting segments
    fprintf(stderr,"%s: writing output\n", o_name);
    FILE *fo = fopen(o_name, "wb");
    if( !fo )
    {
        fprintf(stderr,"%s: can't open output file.\n", o_name);
        free(slist);
        return -1;
    }
    for(i=0; i<snum; i++)
        write_seg(o_name, fo, i, &slist[i]);
    fclose(fo);

    free(slist);
    return 0;
}

int main(int argc, char **argv)
{
    if( argc != 5 )
    {
        fprintf(stderr,"%s: argument error.\n"
                       "Usage: %s <load-high.obx> <load-low.obx> <offset> <output.obx>\n",
                argv[0], argv[0]);
        return -1;
    }

    int off = strtol(argv[3], 0, 0);
    if( off < 0 || off & 0xFF )
    {
        fprintf(stderr, "%s: error, offset must be multiple of 256\n", argv[0]);
        return -1;
    }

    int rnum = 0;
    int loc[65536];
    if( read_files(argv[1], argv[2], off, loc, &rnum) < 0 )
        return 1;

    // Adds a 0 at the end:
    loc[rnum++] = 0;

    // Now, write the output file, copying the first file
    return write_output(argv[1] ,argv[4], 0x5000, loc, rnum);

    return 0;
}
