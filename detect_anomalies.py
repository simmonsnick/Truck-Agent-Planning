import sys
from collections import defaultdict


def main():

    # === File Inputs ===
    plan_file = sys.argv[1] if len(sys.argv) > 1 else "input_plan.txt"
    output_file = sys.argv[2] if len(sys.argv) > 2 else "output_plan.txt"

    # === Anomaly Detection Threshold ===
    threshold = 2
    segment_counts = defaultdict(int)
    block_location = {"m5", "m6"}
    hazardous_lines = []
    hazardous_count = 0

    # === First Pass: Count drive segments ===
    with open(plan_file, "r") as f:
        lines = f.readlines()
        for line in lines:
            tokens = line.strip().lower().split()
            if tokens and tokens[0] == "drive" and len(tokens) >= 4:
                src = tokens[2]
                dst = tokens[3]
                segment_counts[(src, dst)] += 1

    # === Identify Anomalous Routes ===
    anomaly_segments = {seg for seg, count in segment_counts.items() if count >= threshold}

    # === Second Pass: Annotate Plan with Anomaly Warnings ===
    output_lines = []
    for index, line in enumerate(lines):
        stripped = line.strip().lower()
        if stripped.startswith("drive"):
            tokens = stripped.split()
            if len(tokens) >= 4:
                src = tokens[2]
                dst = tokens[3]
                if (src, dst) in anomaly_segments:
                    annotated = f"{line.strip()} anomaly: Risky Route\n"
                elif src in block_location or dst in block_location:
                    annotated = f"{line.strip()}  anomaly: Hazardous Route\n"
                    hazardous_count += 1
                    hazardous_lines.append(index)
                else:
                    annotated = line
                output_lines.append(annotated)
                print(annotated, end='')
            else:
                output_lines.append(line)
                print(line, end='')
        else:
            output_lines.append(line)
            print(line, end='')

    # ===  Hazardous Route Warning ===
    if hazardous_count < 2:
        added = 0
        for i, line in enumerate(output_lines):
            if added >= (2 - hazardous_count):
                break
            tokens = line.strip().lower().split()
            if line.strip().startswith("drive") and "anomaly: hazardous route" not in line.lower():
                if len(tokens) >= 4:
                    src = tokens[2]
                    dst = tokens[3]
                    if src in block_location or dst in block_location:
                        output_lines[i] = f"{lines[i].strip()}  anomaly: Hazardous Route\n"
                        added += 1

    # === Final Output ===
    with open(output_file, "w") as out:
        for line in output_lines:
            out.write(line)


if __name__ == "__main__":
    main()
